from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from .utils.utils import get_version

app = FastAPI(
    title="Feature Template API",
    description="A FastAPI-based template for feature development and deployment",
    version=get_version(),
    docs_url="/docs",  # Swagger UI
    redoc_url="/redoc"  # ReDoc
)

# CORS middleware for web applications
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Configure appropriately for production
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Conditionally include API router if available
try:
    from .api.features import router as features_router
    app.include_router(features_router, prefix="/api/v1", tags=["features"])
except ImportError:
    # API not available, skip
    pass

@app.get("/")
async def root():
    return {"message": "Welcome to the Feature Template API", "version": get_version()}

@app.get("/health")
async def health():
    return {"status": "healthy", "version": get_version()}

# Add your custom logic here for processing or other purposes
if __name__ == "__main__":
    # Example: run custom processing
    print(f"Running custom logic... Version: {get_version()}")