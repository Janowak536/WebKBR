using Microsoft.AspNetCore.Mvc;
using System;
using System.Linq;
using System.Threading.Tasks;
using WebKBR.Domain.Dto;
using WebKBR.Domain.Models;
using WebKBR.Infrastructure;


namespace WebKBR.API.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class OrdersController : ControllerBase
    {
        private readonly Db2kbrContext _context;

        public OrdersController(Db2kbrContext context)
        {
            _context = context;
        }

        [HttpPost]
        public IActionResult CreateOrders([FromBody] List<OrderDto> orderDtos)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            // Generowanie jednego losowego OrderId dla całej listy zamówień
            var orderId = GenerateOrderId();

            var orders = orderDtos.Select(orderDto => new Order
            {
                ClientId = orderDto.ClientID,
                OrderId = orderId,
                ModelId = orderDto.ModelID,
                ColorId = orderDto.ColorID,
                MdfId = orderDto.MdfID,
                Width = orderDto.Width,
                Height = orderDto.Height,
                OrderValue = orderDto.OrderValue
            }).ToList();

            _context.Orders.AddRange(orders);
            _context.SaveChanges();

            return Ok();
        }

        private int GenerateOrderId()
        {
            // Generowanie losowego OrderId
            Random random = new Random();
            return random.Next(1000, 9999);
        }
    }
}
