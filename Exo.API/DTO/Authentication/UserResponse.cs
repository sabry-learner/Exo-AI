
namespace ExoAI.API.DTO.Authentication;
public record UserResponse(
	string Id,
	string? Email,
	string FirstName,
	string LastName
);
