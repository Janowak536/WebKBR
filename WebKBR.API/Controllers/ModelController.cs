using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using WebKBR.Infrastructure;

namespace WebKBR.API.Controllers
{
    public class ModelController : Controller
    {
        private readonly Db2kbrContext _context;

        public ModelController(Db2kbrContext context)
        {
            _context = context;
        }
        [HttpGet("GetModelValue/{modelId}")]
        public IActionResult GetModelValue(int modelId)
        {
            var modelValue = _context.Models.FirstOrDefault(m => m.ModelId == modelId);

            if (modelValue == null)
            {
                return NotFound();
            }

            return Ok(modelValue);
        }

    }
}
