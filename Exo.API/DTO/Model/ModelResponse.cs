namespace ExoAI.API.DTO.Model;
public record ModelResponse(
	string Version,
	decimal Accuracy,
	string TrainedOn,
	DateTime UpdatedAt,
	string? UserId,
	string? TrainingFileUrl
);
