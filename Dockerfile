# Usa una imagen base de .NET 8.0 para el entorno base
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app
EXPOSE 80

# Usa una imagen base de .NET 8.0 para el entorno de compilación
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src
COPY . .
RUN dotnet restore "Restaurante_Sur/Api_Restaurante_Sur.csproj"
RUN dotnet publish "Restaurante_Sur/Api_Restaurante_Sur.csproj" -c Release -o /app/publish

# Usa la imagen base para el entorno final
FROM base AS final
WORKDIR /app
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "Api_Restaurante_Sur.dll"]
