using ExoAI.API.Abstractions.Consts;
using ExoAI.API.DTO.Authentication;
using FluentValidation;

namespace ExoAI.API.DTO.Authentication;

public class RegisterRequestValidator : AbstractValidator<RegisterRequest>
{
	public RegisterRequestValidator()
	{
		RuleFor(x => x.Email)
		.NotEmpty()
		.EmailAddress();

		RuleFor(x => x.Password)
		.NotEmpty()
		.Matches(RegexPatterns.Password)
		.WithMessage("Password should be at least 8 digits and should contains LowerCase, NonAlphanumeric and UpperCase.");

		RuleFor(x => x.FirstName)
		.NotEmpty()
		.Length(3, 50);

		RuleFor(x => x.LastName)
		.NotEmpty()
		.Length(3, 50);
	}
}
