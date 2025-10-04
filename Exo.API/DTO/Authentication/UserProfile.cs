namespace ExoAI.API.DTO.Authentication;

public record UserProfile(
	string Id,
	string Email,
	string FirstName,
	string LastName
);
