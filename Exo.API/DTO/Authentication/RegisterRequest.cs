
namespace ExoAI.API.DTO.Authentication;

public record RegisterRequest(
	string Email,
	string Password,
	string FirstName,
	string LastName
);
