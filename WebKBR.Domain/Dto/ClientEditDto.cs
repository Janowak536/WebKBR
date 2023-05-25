using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace WebKBR.Domain.Dto
{
    public class ClientEditDto
    {
        public int ClientId { get; set; }
        public string ClientType { get; set; }
        public string DiscountCode { get; set; }
    }

}
