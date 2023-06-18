using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Moq;
using System.Collections.Generic;
using System.Linq;
using WebKBR.API.Controllers;
using WebKBR.Domain.Models;
using WebKBR.Infrastructure;
using Xunit;

namespace WebKBR.Test
{
    public class MdfTests
    {
        public class MdfControllerTests
        {
            private readonly Mock<Db2kbrContext> _mockContext;
            private readonly MdfController _mdfController;
            private readonly List<Mdf> _mdfs;

            public MdfControllerTests()
            {
                _mockContext = new Mock<Db2kbrContext>();
                _mdfController = new MdfController(_mockContext.Object);

                _mdfs = new List<Mdf>
                {
                    new Mdf { MdfId = 1, Value = 1.0m },
                    new Mdf { MdfId = 2, Value = 2.0m }
                };

                var mdfData = _mdfs.AsQueryable();
                var mockMdfSet = new Mock<DbSet<Mdf>>();
                mockMdfSet.As<IQueryable<Mdf>>().Setup(m => m.Provider).Returns(mdfData.Provider);
                mockMdfSet.As<IQueryable<Mdf>>().Setup(m => m.Expression).Returns(mdfData.Expression);
                mockMdfSet.As<IQueryable<Mdf>>().Setup(m => m.ElementType).Returns(mdfData.ElementType);
                mockMdfSet.As<IQueryable<Mdf>>().Setup(m => m.GetEnumerator()).Returns(mdfData.GetEnumerator());

                _mockContext.Setup(x => x.Mdfs).Returns(mockMdfSet.Object);
            }

            [Fact]
            public void GetMdfValue_ReturnsOk_WhenMdfExists()
            {
                // Arrange
                var mdfId = 1;

                // Act
                var result = _mdfController.GetMdfValue(mdfId);

                // Assert
                var okResult = Assert.IsType<OkObjectResult>(result);
                var returnValue = Assert.IsType<Mdf>(okResult.Value);
                Assert.Equal(1.0m, returnValue.Value);
            }

            [Fact]
            public void GetMdfValue_ReturnsNotFound_WhenMdfDoesNotExist()
            {
                // Arrange
                var mdfId = 3;

                // Act
                var result = _mdfController.GetMdfValue(mdfId);

                // Assert
                Assert.IsType<NotFoundResult>(result);
            }
        }
    }
}
