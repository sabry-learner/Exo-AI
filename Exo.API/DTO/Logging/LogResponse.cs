namespace ExoAI.API.DTO.Logging;

public record LogResponse(
		int Id,
		string UserI,
		string Action,
		DateTime Timestamp,
		string Details
);
