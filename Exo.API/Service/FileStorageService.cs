using ExoAI.API.Service;

namespace ExoAI.Api.Services;

public class FileStorageService : IFileStorageService
{
	private readonly ILogger<FileStorageService> _logger;
	private static readonly string[] AllowedExtensions = { ".csv", ".json" };
	private const long MaxFileSize = 10 * 1024 * 1024; // 10MB

	public FileStorageService(IConfiguration config, ILogger<FileStorageService> logger)
	{
		_logger = logger ?? throw new ArgumentNullException(nameof(logger));
	}

	public async Task<string> UploadFileAsync(IFormFile file, string fileName, string userId, CancellationToken cancellationToken = default)
	{
		if (file == null || file.Length == 0)
		{
			_logger.LogWarning("Empty file upload attempt by user {UserId}", userId);
			throw new ArgumentException("File is empty or null");
		}

		if (file.Length > MaxFileSize)
		{
			_logger.LogWarning("File size {FileSize} exceeds limit for user {UserId}", file.Length, userId);
			throw new ArgumentException("File size exceeds 10MB");
		}

		var extension = Path.GetExtension(file.FileName).ToLowerInvariant();

		if (!AllowedExtensions.Contains(extension))
		{
			_logger.LogWarning("Invalid file type {Extension} for user {UserId}", extension, userId);
			throw new ArgumentException("Only CSV and JSON files allowed");
		}

		try
		{
			// Temporary file path for ML processing
			var tempFilePath = Path.Combine(Path.GetTempPath(), $"{Guid.NewGuid()}{extension}");
			using (var stream = new FileStream(tempFilePath, FileMode.Create))
			{
				await file.CopyToAsync(stream, cancellationToken);
			}

			_logger.LogInformation("File {FileName} saved temporarily for ML processing by user {UserId}", fileName, userId);

			// Return temp file path for ML processing; database storage handled elsewhere
			return tempFilePath;
		}
		catch (Exception ex)
		{
			_logger.LogError(ex, "Upload failed for user {UserId}, file {FileName}", userId, fileName);
			throw;
		}
	}
}