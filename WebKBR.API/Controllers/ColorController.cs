using Microsoft.AspNetCore.Mvc;
using WebKBR.Infrastructure;

namespace WebKBR.API.Controllers
{
    public class ColorController : Controller
    {
        private readonly Db2kbrContext _context;

        public ColorController(Db2kbrContext context)
        {
            _context = context;
        }
        [HttpGet("GetColorValue/{colorId}")]
        public IActionResult GetColorValue(int colorId)
        {
            var colorValue = _context.Colors.FirstOrDefault(m => m.ColorId == colorId);

            if (colorValue == null)
            {
                return NotFound();
            }

            return Ok(colorValue);
        }

    }
}
