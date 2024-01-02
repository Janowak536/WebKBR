using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace WebKBR.Domain.Dto
{
    public class OrderDto
    {
        [Required]
        public int ClientID { get; set; }

        [Required]
        public int OrderID { get; set; }

        [Required]
        public int ModelID { get; set; }

        [Required]
        public int ColorID { get; set; }

        [Required]
        public int MdfID { get; set; }

        [Required]
        public short Width { get; set; }

        [Required]
        public short Height { get; set; }

        [Required]
        public decimal OrderValue { get; set; }
        public string? OrderStatus { get; set; }
    }
}
