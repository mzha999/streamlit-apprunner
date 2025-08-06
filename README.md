# Streamlit App Runner Project

A simple Streamlit application deployed using AWS App Runner.

## Files

- `app.py` - Simple Streamlit application
- `requirements.txt` - Python dependencies
- `Dockerfile` - Container configuration
- `apprunner.yaml` - App Runner configuration
- `deploy.sh` - Deployment script

## Deployment Steps

1. **Build and push to ECR:**
   ```bash
   ./deploy.sh
   ```

2. **Create App Runner service via AWS Console:**
   - Go to AWS App Runner console
   - Create service
   - Choose "Container registry" as source
   - Select the ECR image URI from the deploy script output
   - Configure service settings (CPU: 0.25 vCPU, Memory: 0.5 GB)
   - Deploy

3. **Alternative: Create via AWS CLI:**
   ```bash
   aws apprunner create-service \
     --service-name streamlit-app-service \
     --source-configuration '{
       "ImageRepository": {
         "ImageIdentifier": "ACCOUNT_ID.dkr.ecr.us-east-1.amazonaws.com/streamlit-app:latest",
         "ImageConfiguration": {
           "Port": "8501"
         },
         "ImageRepositoryType": "ECR"
       },
       "AutoDeploymentsEnabled": false
     }' \
     --instance-configuration '{
       "Cpu": "0.25 vCPU",
       "Memory": "0.5 GB"
     }'
   ```

## Local Testing

```bash
pip install -r requirements.txt
streamlit run app.py
```