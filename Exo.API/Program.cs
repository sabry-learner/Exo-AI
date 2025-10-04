using ExoAI.Api.Services;
using ExoAI.API.Entities;
using ExoAI.API.Persistence;
using ExoAI.API.Service;
using FluentValidation;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using SharpGrip.FluentValidation.AutoValidation.Mvc.Extensions;
using System.Reflection;
using System.Text;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

builder.Services.AddControllers();
// Learn more about configuring OpenAPI at https://aka.ms/aspnet/openapi
builder.Services.AddOpenApi();

// Add Database Context
var connectionString = builder.Configuration.GetConnectionString("DefaultConnection") ??
	throw new InvalidOperationException("Connection string 'DefaultConnection' not found.");

builder.Services.AddDbContext<ApplicationDbContext>(options =>
 options.UseSqlServer(connectionString));


// FluentValidation
builder.Services.AddFluentValidationAutoValidation()
				.AddValidatorsFromAssembly(Assembly.GetExecutingAssembly());


//Authentication & Authorization
builder.Services.AddIdentity<ApplicationUser, IdentityRole>()
	.AddEntityFrameworkStores<ApplicationDbContext>();

//builder.Services.AddSingleton<IJwtProvider, JwtProvider>();


//builder.Services.Configure<JwtOptions>(builder.Configuration.GetSection(JwtOptions.SectionName));// options Pattern
//builder.Services.AddOptions<JwtOptions>()
//				.BindConfiguration(JwtOptions.SectionName)
//				.ValidateDataAnnotations();
				//.ValidateOnStart();

//var JwtSettings = builder.Configuration.GetSection(JwtOptions.SectionName).Get<JwtOptions>();

//builder.Services.AddAuthentication(options => // to define your default token is Bearer
//{
//	options.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
//	options.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
//})
//	.AddJwtBearer(o =>
//	{
//		o.SaveToken = true;
//		o.TokenValidationParameters = new TokenValidationParameters
//		{
//			ValidateIssuerSigningKey = true,
//			ValidateIssuer = true,
//			ValidateAudience = true,
//			ValidateLifetime = true,
//			IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(JwtSettings?.Key!)),
//			ValidIssuer = JwtSettings?.Issuer,
//			ValidAudience = JwtSettings?.Audience
//		};
//	});

builder.Services.Configure<IdentityOptions>(options =>
{
	options.Password.RequiredLength = 8;
	options.User.RequireUniqueEmail = true;	
});


// Add Application Services and Dependencies
builder.Services.AddScoped<IAuthService, AuthService>();
builder.Services.AddScoped<IUserService, UserService>();
builder.Services.AddScoped<IUploadService, UploadService>();
builder.Services.AddScoped<IFileStorageService, FileStorageService>();
builder.Services.AddScoped<IPredictionService, PredictionService>();
builder.Services.AddScoped<IStatsService, StatsService>();
builder.Services.AddScoped<IModelService, ModelService>();
builder.Services.AddScoped<ILogService, LogService>();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
	app.MapOpenApi();
}

app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

app.Run();
