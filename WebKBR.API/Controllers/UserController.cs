using Microsoft.AspNetCore.Mvc;
using System.Threading.Tasks;
using System.Linq;
using BCrypt.Net;
using WebKBR.Domain.Dto;
using Microsoft.Extensions.Configuration;
using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;

namespace WebKBR.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UserController : ControllerBase
    {
        private readonly Db2KbrContext _context;
        private readonly IConfiguration _configuration;
        public UserController(Db2KbrContext context, IConfiguration configuration)
        {
            _context = context;
            _configuration = configuration;
        }


        // Registration endpoint
        [HttpPost("Register")]
        public async Task<IActionResult> Register(UserRegisterDto userRegisterDto)
        {
            // Check if the email already exists
            if (_context.Users.Any(user => user.Email == userRegisterDto.Email))
            {
                return BadRequest("Email already exists");
            }
            // Hash the password
            var hashedPassword = BCrypt.Net.BCrypt.HashPassword(userRegisterDto.Password);

            var user = new User
            {
                Email = userRegisterDto.Email,
                PasswordHash = hashedPassword
            };

            _context.Users.Add(user);
            await _context.SaveChangesAsync();

            return StatusCode(201);
        }

        [HttpPost("Login")]
        public async Task<IActionResult> Login(UserLoginDto userLoginDto)
        {
            // Find the user by email
            var user = _context.Users.SingleOrDefault(user => user.Email == userLoginDto.Email);

            if (user == null)
            {
                return Unauthorized("Invalid email");
            }

            // Verify the password
            var validPassword = BCrypt.Net.BCrypt.Verify(userLoginDto.Password, user.PasswordHash);

            if (!validPassword)
            {
                return Unauthorized("Invalid password");
            }

            // User is authenticated, generate a JWT
            var tokenHandler = new JwtSecurityTokenHandler();
            var key = Encoding.ASCII.GetBytes(_configuration["Jwt:Key"]);
            var tokenDescriptor = new SecurityTokenDescriptor
            {
                Subject = new ClaimsIdentity(new Claim[]
                {
            new Claim(ClaimTypes.Name, user.Email)
                }),
                Expires = DateTime.UtcNow.AddDays(7),
                SigningCredentials = new SigningCredentials(new SymmetricSecurityKey(key), SecurityAlgorithms.HmacSha256Signature)
            };
            var token = tokenHandler.CreateToken(tokenDescriptor);
            var tokenString = tokenHandler.WriteToken(token);

            // Return the token to the client
            return Ok(new { Token = tokenString });
        }


        // Change password endpoint
        [HttpPost("ChangePassword")]
        public async Task<IActionResult> ChangePassword(UserChangePasswordDto userChangePasswordDto)
        {
            // Find the user by email
            var user = _context.Users.SingleOrDefault(user => user.Email == userChangePasswordDto.Email);

            if (user == null)
            {
                return Unauthorized("Invalid email");
            }

            // Verify the old password
            var validPassword = BCrypt.Net.BCrypt.Verify(userChangePasswordDto.OldPassword, user.PasswordHash);

            if (!validPassword)
            {
                return Unauthorized("Invalid old password");
            }

            // Hash the new password and store it
            user.PasswordHash = BCrypt.Net.BCrypt.HashPassword(userChangePasswordDto.NewPassword);
            _context.Users.Update(user);
            await _context.SaveChangesAsync();

            return Ok();
        }
    }
}
