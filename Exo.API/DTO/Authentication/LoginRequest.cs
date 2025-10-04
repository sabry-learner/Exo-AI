namespace ExoAI.API.DTO.Authentication;
public record LoginRequest(
	string Email,
	string Password
);
