using System.Collections.Generic;
using System.Linq;
using Microsoft.AspNetCore.Mvc;
using Moq;
using Xunit;
using WebKBR.API.Controllers;
using WebKBR.Domain.Models;
using WebKBR.Domain.Dto;
using Microsoft.Extensions.Configuration;
using System.Security.Claims;
using Microsoft.AspNetCore.Http;
using WebKBR.Infrastructure;
using Microsoft.EntityFrameworkCore;

using System;
namespace WebKBR.Test
{
    public class UserControllerTests
    {
        private readonly Mock<Db2kbrContext> _mockContext;
        private readonly UserController _userController;
        private readonly List<Client> _clients;
        private readonly Mock<IConfiguration> _mockConfiguration;

        public UserControllerTests()
        {
            _mockContext = new Mock<Db2kbrContext>();
            _mockConfiguration = new Mock<IConfiguration>();

            _userController = new UserController(_mockContext.Object, _mockConfiguration.Object)
            {
                ControllerContext = new ControllerContext
                {
                    HttpContext = new DefaultHttpContext { User = new ClaimsPrincipal() }
                }
            };

            _clients = new List<Client>
            {
                new Client { ClientId = 1, Username = "test1", PasswordHash = BCrypt.Net.BCrypt.HashPassword("test1234"), UserRole = "User" },
                new Client { ClientId = 2, Username = "test2", PasswordHash = BCrypt.Net.BCrypt.HashPassword("test2345"), UserRole = "User" }
            };

            var clientData = _clients.AsQueryable();
            var mockClientSet = new Mock<DbSet<Client>>();
            mockClientSet.As<IQueryable<Client>>().Setup(m => m.Provider).Returns(clientData.Provider);
            mockClientSet.As<IQueryable<Client>>().Setup(m => m.Expression).Returns(clientData.Expression);
            mockClientSet.As<IQueryable<Client>>().Setup(m => m.ElementType).Returns(clientData.ElementType);
            mockClientSet.As<IQueryable<Client>>().Setup(m => m.GetEnumerator()).Returns(clientData.GetEnumerator());

            _mockContext.Setup(x => x.Clients).Returns(mockClientSet.Object);
        }

        [Fact]
        public void Login_ReturnsOk_WhenUserExistsAndPasswordIsValid()
        {
            // Arrange
            var userLoginDto = new UserLoginDto { Username = "test1", Password = "test1234" };

            _mockConfiguration.Setup(x => x["Jwt:Key"]).Returns("a_long_and_secure_key_that_is_at_least_32_characters");

            // Act
            var result = _userController.Login(userLoginDto);

            // Assert
            var okResult = Assert.IsType<OkObjectResult>(result.Result);
        }

        [Fact]
        public void Login_ReturnsUnauthorized_WhenUserDoesNotExist()
        {
            // Arrange
            var userLoginDto = new UserLoginDto { Username = "test3", Password = "test3456" };

            // Act
            var result = _userController.Login(userLoginDto);

            // Assert
            Assert.IsType<UnauthorizedObjectResult>(result.Result);
        }

        [Fact]
        public void Register_ReturnsBadRequest_WhenUserExists()
        {
            // Arrange
            var userRegisterDto = new UserRegisterDto { Username = "test1", Password = "test1234" };

            // Act
            var result = _userController.Register(userRegisterDto);

            // Assert
            Assert.IsType<BadRequestObjectResult>(result.Result);
        }
    }
}
