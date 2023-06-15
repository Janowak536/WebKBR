using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using WebKBR.Infrastructure;

namespace WebKBR.API.Controllers
{
    public class MdfController : Controller
    {
        private readonly Db2kbrContext _context;

        public MdfController(Db2kbrContext context)
        {
            _context = context;
        }
        [HttpGet("GetMdfValue/{mdfId}")]
        public IActionResult GetMdfValue(int mdfId)
        {
            var mdfValue = _context.Mdfs.FirstOrDefault(m => m.MdfId == mdfId);

            if (mdfValue == null)
            {
                return NotFound();
            }

            return Ok(mdfValue);
        }

    }
}
