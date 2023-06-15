using Microsoft.AspNetCore.Mvc;
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
        public IActionResult CreateOrder(OrderDto orderDto)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var order = new Order
            {
                ClientId = orderDto.ClientID,
                OrderId = orderDto.OrderID,
                ModelId = orderDto.ModelID,
                ColorId = orderDto.ColorID,
                MdfId = orderDto.MdfID,
                Width = orderDto.Width,
                Height = orderDto.Height,
                OrderValue = orderDto.OrderValue
            };

            _context.Orders.Add(order);
            _context.SaveChanges();

            return Ok();
        }
    }
}
