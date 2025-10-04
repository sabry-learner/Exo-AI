//using ExoAI.API.Entities;
//using Microsoft.Extensions.Options;
//using Microsoft.IdentityModel.Tokens;
//using System.IdentityModel.Tokens.Jwt;
//using System.Security.Claims;
//using System.Text;

//namespace ExoAI.API.Authentication;

//public class JwtProvider : IJwtProvider
//{
//	private JwtOptions _options;
//	public JwtProvider(IOptions<JwtOptions> options)
//	{
//		_options = options.Value;
//	}

//	public (string token, int expiresIn) GenerateToken(ApplicationUser user)
//	{
//		Claim[] claims = [
//			new (JwtRegisteredClaimNames.Sub , user.Id),
//			new (JwtRegisteredClaimNames.Email , user.Email!),
//			new (JwtRegisteredClaimNames.GivenName , user.FirstName),
//			new (JwtRegisteredClaimNames.FamilyName , user.LastName),
//			new (JwtRegisteredClaimNames.Jti , Guid.NewGuid().ToString()),
//		];

//		var symmetricSecurityKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(_options.Key));

//		var signingCredentials = new SigningCredentials(symmetricSecurityKey, SecurityAlgorithms.HmacSha256);


//		var expirationDate = DateTime.UtcNow.AddMinutes(_options.ExpiryMinutes);

//		var token = new JwtSecurityToken(
//			issuer: _options.Issuer,
//			audience: _options.Audience,
//			claims: claims,
//			expires: expirationDate,
//			signingCredentials: signingCredentials
//		);

//		return (token: new JwtSecurityTokenHandler().WriteToken(token), expiresIn: _options.ExpiryMinutes * 60);
//	}

//	public string? ValidateToken(string token)
//	{
//		var tokenHandler = new JwtSecurityTokenHandler();
//		var symmetricSecurityKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(_options.Key));

//		try
//		{
//			tokenHandler.ValidateToken(token, new TokenValidationParameters
//			{
//				IssuerSigningKey = symmetricSecurityKey,
//				ValidateIssuerSigningKey = true,
//				ValidateIssuer = false,
//				ValidateAudience = false,
//				ClockSkew = TimeSpan.Zero
//			}, out SecurityToken validatedToken);

//			var jwtToken = (JwtSecurityToken)validatedToken;

//			return jwtToken.Claims.First(x => x.Type == JwtRegisteredClaimNames.Sub).Value;
//		}
//		catch
//		{
//			return null;
//		}

//	}
//}
