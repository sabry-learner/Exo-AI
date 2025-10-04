namespace ExoAI.API.Entities;

public class Model
{
	public int Id { get; set; } // PK, auto-increment
	public string Version { get; set; } = string.Empty;  // varchar(50)
	public decimal Accuracy { get; set; } // decimal(5,4)
	public string? TrainedOn { get; set; }
	public DateTime UpdatedAt { get; set; } // datetime, default GETDATE()
	public string UserId { get; set; } = null!; // nullable, FK to Users
	public ApplicationUser User { get; set; } = null!; // Navigation property
}