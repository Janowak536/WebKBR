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
    public class ModelTests
    {
        public class ModelControllerTests
        {
            private readonly Mock<Db2kbrContext> _mockContext;
            private readonly ModelController _modelController;
            private readonly List<Model> _models;

            public ModelControllerTests()
            {
                _mockContext = new Mock<Db2kbrContext>();
                _modelController = new ModelController(_mockContext.Object);

                _models = new List<Model>
                {
                    new Model { ModelId = 1, Value = 1.0m },
                    new Model { ModelId = 2, Value = 2.0m }
                };

                var modelData = _models.AsQueryable();
                var mockModelSet = new Mock<DbSet<Model>>();
                mockModelSet.As<IQueryable<Model>>().Setup(m => m.Provider).Returns(modelData.Provider);
                mockModelSet.As<IQueryable<Model>>().Setup(m => m.Expression).Returns(modelData.Expression);
                mockModelSet.As<IQueryable<Model>>().Setup(m => m.ElementType).Returns(modelData.ElementType);
                mockModelSet.As<IQueryable<Model>>().Setup(m => m.GetEnumerator()).Returns(modelData.GetEnumerator());

                _mockContext.Setup(x => x.Models).Returns(mockModelSet.Object);
            }

            [Fact]
            public void GetModelValue_ReturnsOk_WhenModelExists()
            {
                // Arrange
                var modelId = 1;

                // Act
                var result = _modelController.GetModelValue(modelId);

                // Assert
                var okResult = Assert.IsType<OkObjectResult>(result);
                var returnValue = Assert.IsType<Model>(okResult.Value);
                Assert.Equal(1.0m, returnValue.Value);
            }

            [Fact]
            public void GetModelValue_ReturnsNotFound_WhenModelDoesNotExist()
            {
                // Arrange
                var modelId = 3;

                // Act
                var result = _modelController.GetModelValue(modelId);

                // Assert
                Assert.IsType<NotFoundResult>(result);
            }
        }
    }
}
