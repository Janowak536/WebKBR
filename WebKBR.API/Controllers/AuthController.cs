using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;
using WebKBR.Domain.Dto;

namespace _2KBR.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AuthController : ControllerBase
    {
        public static User user = new User();
        private readonly IConfiguration _configuration;

        public AuthController(IConfiguration configuration)
        {
            _configuration = configuration;
        }
        [HttpGet,Authorize]
        public ActionResult<string> GetMe()
        {
            var userName = User?.Identity?.Name;
            return Ok(userName);

        }
        [HttpPost("register")]
        public async Task<ActionResult<User>> Register(UserDto request)
        {
            string passwordHash = BCrypt.Net.BCrypt.HashPassword(request.Password);

            user.Email = request.Username;
            user.PasswordHash = passwordHash;

            return Ok("Registered");
        }
        [HttpPost("login")]
        public async Task<ActionResult<User>> Login(UserDto request)
        {
            if(user.Email != request.Username)
            {
                return BadRequest("User not found");

            }
            if (!BCrypt.Net.BCrypt.Verify(request.Password, user.PasswordHash))
            {
                return BadRequest("Wrong password.");
            }
            string token = await CreateToken(user);

            return Ok(new { token });
        }
        private async Task<string> CreateToken(User user)
        {
            List<Claim> claims = new List<Claim> { 
                new Claim(ClaimTypes.Email, user.Email),
                new Claim(ClaimTypes.Role, "Admin")
            };
            var key = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(
                _configuration.GetSection("AppSettings:Token").Value!));

            var creds = new SigningCredentials(key, SecurityAlgorithms.HmacSha512Signature);

            var token = new JwtSecurityToken(
                    claims:claims,
                    expires:DateTime.Now.AddDays(1),
                    signingCredentials:creds
                );
            var jwt = new JwtSecurityTokenHandler().WriteToken(token);

            return jwt;
        }
    }
}
