namespace ExoAI.API.Service {
    public interface IFileStorageService {
        Task<string> UploadFileAsync(IFormFile file, string fileName, string userId, CancellationToken cancellationToken = default);
    }
}
