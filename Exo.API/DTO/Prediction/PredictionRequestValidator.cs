using ExoAI.API.DTO.Model;
using ExoAI.API.DTO.Prediction;
using FluentValidation;

namespace ExoAI.API.DTO.Prediction;

public class PredictionRequestValidator : AbstractValidator<PredictionRequest>
{
	public PredictionRequestValidator()
	{
		RuleFor(x => x.UploadId)
			.NotEmpty();
	}
}