using System;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.DependencyInjection;


[assembly: HostingStartup(typeof(eventcounterhook.MetricsInjection))]

namespace eventcounterhook
{
    public class MetricsInjection : IHostingStartup
    {
        public void Configure(IWebHostBuilder builder)
        {
            builder.ConfigureServices(services =>
            {
                services.AddMetrics();
                services.AddTransient<IStartupFilter, MetricsStartupFilter>();
            });
        }
    }
}
