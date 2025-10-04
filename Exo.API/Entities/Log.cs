using System.ComponentModel.DataAnnotations;

namespace ExoAI.API.Entities;

public class Log
{
	public int Id { get; set; } // PK, auto-increment
	public string Action { get; set; } = string.Empty; // varchar(100)
	public DateTime Timestamp { get; set; } // datetime, default GETDATE()
	public string? Details { get; set; }  
	public string UserId { get; set; } = null!; // FK to Users
	public ApplicationUser User { get; set; } = null!; // Navigation property
}