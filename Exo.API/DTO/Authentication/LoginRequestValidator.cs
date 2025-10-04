using ExoAI.API.DTO.Authentication;
using FluentValidation;

namespace ExoAI.API.DTO.Authentication;

public class ModelCreateRequestValidator : AbstractValidator<LoginRequest>
{
	public ModelCreateRequestValidator()
	{
		RuleFor(x => x.Email)
			.NotEmpty()
			.EmailAddress();

		RuleFor(x => x.Password)
			.NotEmpty();
			 
	}
}
