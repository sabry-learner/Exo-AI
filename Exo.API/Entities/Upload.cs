using System.ComponentModel.DataAnnotations;

namespace ExoAI.API.Entities;

public enum UploadStatus
{
	Pending,
	Processed,
    Completed
}
public class Upload
{
	[Key] 
	public int Id { get; set; }
	
	[Required, StringLength(500)] 
	public string FilePath { get; set; } = null!;
	
	[Required, StringLength(255)] 
	public string FileName { get; set; } = null!;
	
	[Required] 
	public DateTime UploadDate { get; set; }
	
	[Required] 
	public UploadStatus Status { get; set; }

	[Required]
	public string UserId { get; set; } = null!;
	public virtual ApplicationUser User { get; set; } = null!;
}