using ExoAI.API.DTO.Upload;

namespace ExoAI.API.Service
{
    public interface IUploadService {
        Task<UploadResponse> UploadFileAsync(IFormFile file, string userId, CancellationToken cancellationToken = default);
    }
}
