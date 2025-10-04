namespace ExoAI.API.Entities;
public enum PredictionClass 
{ 
	Exoplanet,
	Candidate,
	FalsePositive 
}
public class Prediction
{
	public int Id { get; set; } // PK, auto-increment
	public PredictionClass Class { get; set; } // enum
	public decimal Confidence { get; set; } // decimal(5,4)
	public string Features { get; set; } = string.Empty; 
	public DateTime PredictedAt { get; set; } // datetime, default GETDATE()
	public int UploadId { get; set; } // FK to Uploads
	public Upload Upload { get; set; } = null!; // Navigation property
}