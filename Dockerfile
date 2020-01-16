  
#build hook
FROM mcr.microsoft.com/dotnet/core/sdk:3.1 as build1

WORKDIR /build
COPY src/eventcounterhook/ .
RUN dotnet publish -c Release -o out

#build app
FROM mcr.microsoft.com/dotnet/core/sdk:3.1 as build2

WORKDIR /app
COPY sample/webapp/ .
RUN dotnet publish -c Release -o out

#runtime container
FROM mcr.microsoft.com/dotnet/core/aspnet:3.1

COPY --from=build1 /build/out /hook
WORKDIR /app
COPY --from=build2 /app/out ./
ENV DOTNET_STARTUP_HOOKS="/hook/eventcounterhook.dll"
ENV ASPNETCORE_HOSTINGSTARTUPASSEMBLIES="eventcounterhook"
WORKDIR /app

ENTRYPOINT ["dotnet", "webapp.dll"]

