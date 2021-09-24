#build hook
FROM mcr.microsoft.com/dotnet/core/sdk:3.1 as buildhook

WORKDIR /build
COPY src/eventcounterhook/ .
RUN dotnet publish -c Release -o out

#runtime container
FROM mcr.microsoft.com/dotnet/samples:aspnetapp

COPY --from=buildhook /build/out /hook
ENV DOTNET_STARTUP_HOOKS="/hook/eventcounterhook.dll"
ENV ASPNETCORE_HOSTINGSTARTUPASSEMBLIES="eventcounterhook"
