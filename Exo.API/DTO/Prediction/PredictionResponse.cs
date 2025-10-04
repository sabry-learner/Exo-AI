namespace ExoAI.API.DTO.Prediction;

public record PredictionResponse(
	 PredictionItem[] Predictions
);

public class PredictionItem
{
	public string Class { get; set; } = null!;
	public decimal Confidence { get; set; }
}