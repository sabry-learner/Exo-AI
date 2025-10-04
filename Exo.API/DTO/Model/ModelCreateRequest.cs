namespace ExoAI.API.DTO.Model;

public record ModelCreateRequest(
	string Version,
	decimal Accuracy,
	string TrainedOn
);
