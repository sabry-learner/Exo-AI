using ExoAI.API.DTO.Model;
using FluentValidation;

namespace ExoAI.API.DTO.Model;

public class PredictionRequestValidator : AbstractValidator<ModelCreateRequest>
{
	public PredictionRequestValidator()
	{
		RuleFor(x => x.Version)
			.NotEmpty();
		
		RuleFor(x => x.Accuracy)
			.NotEmpty();

		RuleFor(x => x.TrainedOn)
			.NotEmpty();
	}
}