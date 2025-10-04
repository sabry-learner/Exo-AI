using ExoAI.API.DTO.Prediction;

namespace ExoAI.API.Service;


public interface IPredictionService
{
	Task<PredictionResponse> PredictAsync(int uploadId, CancellationToken cancellationToken = default);
}