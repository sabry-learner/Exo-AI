using ExoAI.Api.Services;
using ExoAI.API.DTO.Upload;
using ExoAI.API.Entities;
using ExoAI.API.Persistence;
using Microsoft.EntityFrameworkCore;

namespace ExoAI.API.Service 
{
    public class UploadService : IUploadService 
    {
        private readonly IFileStorageService _fileStorageService;
        private readonly ApplicationDbContext _context;
        private readonly ILogger<UploadService> _logger;

        public UploadService(IFileStorageService fileStorageService, ApplicationDbContext context, ILogger<UploadService> logger) {
            _fileStorageService = fileStorageService;
            _context = context;
            _logger = logger;
        }

        public async Task<UploadResponse> UploadFileAsync(IFormFile file, string userId, CancellationToken cancellationToken = default) {
            if (string.IsNullOrEmpty(userId)) {
                _logger.LogWarning("Upload attempt with invalid userId");
                throw new ArgumentException("User ID is required");
            }

            var userExists = await _context.Users.AnyAsync(u => u.Id == userId, cancellationToken);
            if (!userExists) {
                _logger.LogWarning("User {UserId} not found for upload", userId);
                throw new ArgumentException("User not found");
            }

            try {
                var fileName = $"{Guid.NewGuid()}_{file.FileName}";
                var filePath = await _fileStorageService.UploadFileAsync(file, fileName, userId);

                var upload = new Upload {
                    UserId = userId,
                    FilePath = filePath,
                    FileName = file.FileName,
                    UploadDate = DateTime.UtcNow,
                    Status = UploadStatus.Pending
                };

                _context.Uploads.Add(upload);
                await _context.SaveChangesAsync(cancellationToken);

                _logger.LogInformation("File {FileName} uploaded by user {UserId}, uploadId: {UploadId}", fileName, userId, upload.Id);
                return new UploadResponse(
                      upload.Id,
                     upload.Status.ToString()
                );
            } 
            catch (Exception ex) 
            {
                _logger.LogError(ex, "Upload failed for user {UserId}", userId);
                throw;
            }
        }
    }
}
