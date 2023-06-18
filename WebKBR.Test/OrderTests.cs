using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Moq;
using System.Collections.Generic;
using System.Linq;
using WebKBR.API.Controllers;
using WebKBR.Domain.Dto;
using WebKBR.Domain.Models;
using WebKBR.Infrastructure;
using Xunit;

namespace WebKBR.Test
{
    public class OrdersControllerTests
    {
        private readonly Mock<Db2kbrContext> _mockContext;
        private readonly OrdersController _ordersController;
        private readonly List<Model> _models;
        private readonly List<Color> _colors;
        private readonly List<Mdf> _mdfs;

        public OrdersControllerTests()
        {
            _mockContext = new Mock<Db2kbrContext>();

            _ordersController = new OrdersController(_mockContext.Object);

            _models = new List<Model>
            {
                new Model { ModelId = 1, ModelName = "Model 1", Value = 1.0m },
                new Model { ModelId = 2, ModelName = "Model 2", Value = 2.0m }
            };

            _colors = new List<Color>
            {
                new Color { ColorId = 1, Value = 1.0m },
                new Color { ColorId = 2, Value = 2.0m }
            };

            _mdfs = new List<Mdf>
            {
                new Mdf { MdfId = 1, Value = 1.0m },
                new Mdf { MdfId = 2, Value = 2.0m }
            };

            var mockModels = MockDbSet(_models);
            var mockColors = MockDbSet(_colors);
            var mockMdfs = MockDbSet(_mdfs);

            Moq.Language.Flow.IReturnsResult<Db2kbrContext> returnsResult1 = _mockContext.Setup(x => x.Models).Returns(mockModels);
            Moq.Language.Flow.IReturnsResult<Db2kbrContext> returnsResult = _mockContext.Setup(x => x.Colors).Returns(mockColors);
            Moq.Language.Flow.IReturnsResult<Db2kbrContext> returnsResult2 = _mockContext.Setup(x => x.Mdfs).Returns(mockMdfs);
        }

        private static DbSet<T> MockDbSet<T>(List<T> list) where T : class
        {
            var queryableList = list.AsQueryable();
            var dbSetMock = new Mock<DbSet<T>>();
            dbSetMock.As<IQueryable<T>>().Setup(m => m.Provider).Returns(queryableList.Provider);
            dbSetMock.As<IQueryable<T>>().Setup(m => m.Expression).Returns(queryableList.Expression);
            dbSetMock.As<IQueryable<T>>().Setup(m => m.ElementType).Returns(queryableList.ElementType);
            dbSetMock.As<IQueryable<T>>().Setup(m => m.GetEnumerator()).Returns(() => queryableList.GetEnumerator());
            return dbSetMock.Object;
        }


        [Fact]
        public void CreateOrders_ReturnsBadRequest_WhenModelStateIsInvalid()
        {
            // Arrange
            var orderDtos = new List<OrderDto>
            {
                new OrderDto // Missing required properties
                {
                    Width = 10,
                    Height = 10
                }
            };
            _ordersController.ModelState.AddModelError("ClientID", "The ClientID field is required.");
            _ordersController.ModelState.AddModelError("OrderID", "The OrderID field is required.");
            _ordersController.ModelState.AddModelError("ModelID", "The ModelID field is required.");
            _ordersController.ModelState.AddModelError("ColorID", "The ColorID field is required.");
            _ordersController.ModelState.AddModelError("MdfID", "The MdfID field is required.");

            // Act
            var result = _ordersController.CreateOrders(orderDtos);

            // Assert
            Assert.IsType<BadRequestObjectResult>(result);
        }


        [Fact]
        public void CalculateOrderValue_ReturnsBadRequest_WhenInvalidOrderData()
        {
            // Arrange
            var orderDtos = new List<OrderDto>
            {
                new OrderDto // Invalid ModelId, ColorId, MdfId
                {
                    ClientID = 1,
                    OrderID = 1,
                    ModelID = 999,
                    ColorID = 999,
                    MdfID = 999,
                    Width = 10,
                    Height = 10,
                    OrderValue = 100
                }
            };

            // Act
            var result = _ordersController.CalculateOrderValue(orderDtos) as BadRequestObjectResult;

            // Assert
            Assert.NotNull(result);
            Assert.Equal("Invalid order data", result.Value);
        }
    }
}
