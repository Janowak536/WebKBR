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
using Microsoft.AspNetCore.Authorization;
using Microsoft.EntityFrameworkCore;

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


        [HttpPost("Register")]
        public async Task<IActionResult> Register(UserRegisterDto userRegisterDto)
        {
            // Check if the email already exists
            if (_context.Users.Any(user => user.Username == userRegisterDto.Username))
            {
                return BadRequest("Email already exists");
            }

            // Hash the password
            var hashedPassword = BCrypt.Net.BCrypt.HashPassword(userRegisterDto.Password);

            var client = new Client
            {
                Name = userRegisterDto.Name,
                NIP = userRegisterDto.NIP,
                Phone = userRegisterDto.Phone,
                Email = userRegisterDto.Email,
                Address = userRegisterDto.Address,
                City = userRegisterDto.City,
                PostalCode = userRegisterDto.PostalCode,
                ClientType = userRegisterDto.ClientType,
                DiscountCode = userRegisterDto.DiscountCode
            };

            _context.Clients.Add(client);
            await _context.SaveChangesAsync();

            var user = new User
            {
                Username = userRegisterDto.Username,
                PasswordHash = hashedPassword,
                ClientId = client.ClientId  // assuming ClientId is the generated id of the client
            };

            _context.Users.Add(user);
            await _context.SaveChangesAsync();

            return StatusCode(201);
        }


        [HttpPost("Login")]
        public async Task<IActionResult> Login(UserLoginDto userLoginDto)
        {
            // Find the user by email
            var user = _context.Users.SingleOrDefault(user => user.Username == userLoginDto.Username);

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
            new Claim(ClaimTypes.Name, user.Username),
            new Claim(ClaimTypes.Role, user.Role)  // Add this line
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
            var user = _context.Users.SingleOrDefault(user => user.Username == userChangePasswordDto.Username);

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
        [HttpGet("IsAdmin")]
        [Authorize]
        public async Task<IActionResult> IsAdmin()
        {
            var username = User.Identity?.Name;

            if (string.IsNullOrEmpty(username))
            {
                return Unauthorized();
            }

            var user = await _context.Users.SingleOrDefaultAsync(u => u.Username == username);

            if (user == null)
            {
                return Unauthorized();
            }

            var isAdmin = user.Role == "admin";

            return Ok(new { IsAdmin = isAdmin });
        }

    }
}
