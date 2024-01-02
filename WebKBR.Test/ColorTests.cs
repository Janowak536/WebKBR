using Microsoft.AspNetCore.Mvc;
using Moq;
using WebKBR.API.Controllers;
using WebKBR.Infrastructure;
using System.Collections.Generic;
using System.Linq;
using Xunit;
using Microsoft.EntityFrameworkCore;
using WebKBR.Domain.Models;

namespace WebKBR.Test
{
    public class ColorTests
    {
        public class ColorControllerTests
        {
            private readonly Mock<Db2kbrContext> _mockContext;
            private readonly ColorController _colorController;
            private readonly List<Color> _colors;

            public ColorControllerTests()
            {
                _mockContext = new Mock<Db2kbrContext>();
                _colorController = new ColorController(_mockContext.Object);

                _colors = new List<Color>
                {
                    new Color { ColorId = 1, Value = 1.0m },
                    new Color { ColorId = 2, Value = 2.0m }
                };

                var colorData = _colors.AsQueryable();
                var mockColorSet = new Mock<DbSet<Color>>();
                mockColorSet.As<IQueryable<Color>>().Setup(m => m.Provider).Returns(colorData.Provider);
                mockColorSet.As<IQueryable<Color>>().Setup(m => m.Expression).Returns(colorData.Expression);
                mockColorSet.As<IQueryable<Color>>().Setup(m => m.ElementType).Returns(colorData.ElementType);
                mockColorSet.As<IQueryable<Color>>().Setup(m => m.GetEnumerator()).Returns(colorData.GetEnumerator());

                _mockContext.Setup(x => x.Colors).Returns(mockColorSet.Object);
            }

            [Fact]
            public void GetColorValue_ReturnsOk_WhenColorExists()
            {
                var colorId = 1;

                var result = _colorController.GetColorValue(colorId);

                var okResult = Assert.IsType<OkObjectResult>(result);
                var returnValue = Assert.IsType<Color>(okResult.Value);
                Assert.Equal(1.0m, returnValue.Value);
            }

            [Fact]
            public void GetColorValue_ReturnsNotFound_WhenColorDoesNotExist()
            {
                var colorId = 3;

                var result = _colorController.GetColorValue(colorId);

                Assert.IsType<NotFoundResult>(result);
            }
        }
    }
}
