# DevSecOps Netflix Clone Project

A comprehensive DevSecOps implementation demonstrating enterprise-level CI/CD practices with integrated security scanning, monitoring, and GitOps deployment to Kubernetes.

## 🎯 Project Overview

This project showcases a complete software delivery lifecycle using modern DevSecOps practices. The application is a Netflix clone that fetches movie data from TMDB API, deployed through an automated pipeline with security scanning at every stage.

## 🏗️ Architecture
<img width="760" height="450" alt="final architecture drawio (1)" src="https://github.com/user-attachments/assets/121a4b0d-6b02-4ea2-94ee-faab7dec022a" />


## 🛠️ Technology Stack

### Core Application
- **Frontend**: React.js with Node.js
- **API**: TMDB (The Movie Database) for movie data
- **Containerization**: Docker

### DevOps & Infrastructure
- **CI/CD**: Jenkins with Blue Ocean
- **Source Control**: GitHub
- **Container Registry**: Docker Hub
- **Orchestration**: Kubernetes (Amazon EKS)
- **GitOps**: ArgoCD

### Security Tools
- **Code Quality**: SonarQube
- **Vulnerability Scanning**: Trivy
- **Dependency Check**: OWASP Dependency Check

### Monitoring & Observability
- **Metrics Collection**: Prometheus
- **Visualization**: Grafana
- **Node Monitoring**: Node Exporter

### Cloud Infrastructure
- **Cloud Provider**: AWS
- **Compute**: EC2 instances (t2.large, t2.medium)
- **Kubernetes**: Amazon EKS
- **Networking**: VPC, Security Groups, Elastic IPs

## 🚀 Features

- **Automated CI/CD Pipeline**: Code changes trigger automatic builds, tests, and deployments
- **Multi-layer Security Scanning**: Code quality, dependency vulnerabilities, and container image scanning
- **GitOps Deployment**: Automated synchronization between Git repository and Kubernetes cluster
- **Real-time Monitoring**: Infrastructure and application monitoring with alerting
- **Email Notifications**: Automated build reports with security scan results
- **Production-ready Architecture**: Scalable, secure, and maintainable infrastructure

## 📋 Prerequisites

- AWS Account with appropriate permissions
- TMDB API Key (free registration at https://www.themoviedb.org/)
- Docker Hub account
- GitHub account
- Basic knowledge of:
  - Linux command line
  - Docker concepts
  - Kubernetes basics
  - AWS services

## 💰 Cost Estimation

**Estimated AWS costs for this project**: $50-100 USD

- EKS Cluster: ~$0.10/hour
- t2.large EC2: ~$0.09/hour  
- t2.medium EC2: ~$0.05/hour
- Load Balancer: ~$0.025/hour
- Data transfer and storage: minimal

**Important**: Remember to clean up resources after testing to avoid ongoing charges.

## 🔧 Installation & Setup

### Phase 1: Infrastructure Setup

1. **Create Main Server (Jenkins & Security Tools)**
   ```bash
   # Launch t2.large EC2 instance with Ubuntu 22.04
   # Configure security group with ports: 22, 80, 443, 8080, 8081, 9000
   # Attach Elastic IP for consistency
   ```

2. **Create Monitoring Server**
   ```bash
   # Launch t2.medium EC2 instance
   # Configure security group with ports: 22, 3000, 9090, 9100
   # Attach Elastic IP
   ```

### Phase 2: Application Setup

1. **Clone Repository**
   ```bash
   git clone <repository-url>
   cd devsecops-netflix-project
   ```

2. **Install Docker**
   ```bash
   sudo apt update -y
   sudo apt install docker.io -y
   sudo usermod -aG docker $USER
   sudo chmod 777 /var/run/docker.sock
   ```

3. **Build and Test Application**
   ```bash
   # Get TMDB API key from https://www.themoviedb.org/
   docker build --build-arg TMDB_V3_API_KEY=<your-api-key> -t netflix .
   docker run -d -p 8081:80 netflix
   ```

### Phase 3: Security Tools

1. **Install SonarQube**
   ```bash
   docker run -d --name sonar -p 9000:9000 sonarqube:lts-community
   ```

2. **Install Trivy**
   ```bash
   # Install Trivy for vulnerability scanning
   sudo apt-get install wget apt-transport-https gnupg lsb-release
   wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | sudo apt-key add -
   echo "deb https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main" | sudo tee -a /etc/apt/sources.list.d/trivy.list
   sudo apt-get update
   sudo apt-get install trivy
   ```

### Phase 4: CI/CD Pipeline

1. **Install Jenkins**
   ```bash
   # Install Java
   sudo apt install fontconfig openjdk-17-jre -y
   
   # Install Jenkins
   sudo wget -O /usr/share/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
   echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
   sudo apt-get update
   sudo apt-get install jenkins -y
   ```

2. **Configure Jenkins**
   - Install required plugins: NodeJS, SonarQube Scanner, Docker, OWASP Dependency Check
   - Configure tools: JDK 17, NodeJS 16, SonarQube Scanner, Docker
   - Set up credentials: Docker Hub, SonarQube token

### Phase 5: Monitoring Setup

1. **Install Prometheus**
   ```bash
   # Create prometheus user
   sudo useradd --no-create-home --shell /bin/false prometheus
   
   # Download and install Prometheus
   cd /tmp
   wget https://github.com/prometheus/prometheus/releases/download/v2.47.1/prometheus-2.47.1.linux-amd64.tar.gz
   tar xvfz prometheus-2.47.1.linux-amd64.tar.gz
   
   # Configure Prometheus
   sudo mkdir /etc/prometheus /var/lib/prometheus
   sudo cp prometheus-2.47.1.linux-amd64/prometheus /usr/local/bin/
   sudo cp prometheus-2.47.1.linux-amd64/promtool /usr/local/bin/
   sudo cp -r prometheus-2.47.1.linux-amd64/consoles /etc/prometheus
   sudo cp -r prometheus-2.47.1.linux-amd64/console_libraries /etc/prometheus
   sudo cp prometheus-2.47.1.linux-amd64/prometheus.yml /etc/prometheus
   sudo chown -R prometheus:prometheus /etc/prometheus /var/lib/prometheus
   ```

2. **Install Grafana**
   ```bash
   sudo apt-get install -y apt-transport-https software-properties-common wget
   sudo mkdir -p /etc/apt/keyrings/
   wget -q -O - https://apt.grafana.com/gpg.key | gpg --dearmor | sudo tee /etc/apt/keyrings/grafana.gpg > /dev/null
   echo "deb [signed-by=/etc/apt/keyrings/grafana.gpg] https://apt.grafana.com stable main" | sudo tee -a /etc/apt/sources.list.d/grafana.list
   sudo apt-get update
   sudo apt-get install grafana -y
   ```

### Phase 6: Kubernetes Deployment

1. **Create EKS Cluster**
   ```bash
   # Use AWS Console or CLI to create EKS cluster
   # Create node group with t3.medium instances
   ```

2. **Install ArgoCD**
   ```bash
   kubectl create namespace argocd
   kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
   
   # Expose ArgoCD server
   kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'
   ```

## 🔐 Security Features

### Code Quality Analysis
- **SonarQube**: Analyzes 3000+ lines of code for bugs, vulnerabilities, and code smells
- **Quality Gates**: Automated quality checks before deployment

### Vulnerability Scanning
- **Trivy**: Scans filesystem and Docker images for security vulnerabilities
- **OWASP Dependency Check**: Identifies vulnerable dependencies in Node.js packages

### Container Security
- **Multi-stage Docker builds**: Optimized and secure container images
- **Regular base image updates**: Automated scanning of base images

## 📊 Monitoring & Observability

### Metrics Collection
- **Prometheus**: Collects metrics from Jenkins, nodes, and Kubernetes
- **Node Exporter**: System-level metrics (CPU, memory, disk, network)

### Visualization
- **Grafana Dashboards**:
  - Jenkins performance and build metrics
  - Infrastructure monitoring (CPU, memory, disk usage)
  - Kubernetes cluster health

### Alerting
- **Email Notifications**: Build status and security scan reports
- **Real-time Monitoring**: Infrastructure and application health

## 🔄 CI/CD Pipeline Stages

1. **Clean Workspace**: Prepare clean environment for build
2. **Checkout Code**: Pull latest changes from GitHub
3. **SonarQube Analysis**: Code quality and security analysis
4. **Quality Gate**: Automated quality checks
5. **Install Dependencies**: NPM package installation
6. **OWASP Scan**: Dependency vulnerability checking
7. **Trivy FS Scan**: Filesystem vulnerability scanning
8. **Docker Build**: Container image creation with API key
9. **Docker Push**: Upload image to Docker Hub registry
10. **Trivy Image Scan**: Container image vulnerability scanning
11. **Deploy Container**: Local deployment for testing
12. **Email Notification**: Send build report with security scans

## 🚀 GitOps Workflow

1. **Code Changes**: Developer pushes changes to GitHub
2. **Jenkins Pipeline**: Automated build and security scanning
3. **Image Registry**: Secure container image stored in Docker Hub
4. **ArgoCD Sync**: Automatic deployment to Kubernetes cluster
5. **Monitoring**: Real-time observability of deployed application

## 📁 Project Structure

```
devsecops-netflix-project/
├── src/                    # React.js application source code
├── public/                 # Static assets
├── kubernetes/             # Kubernetes manifests
│   ├── deployment.yaml
│   └── service.yaml
├── docker/                 # Docker configuration
│   └── Dockerfile
├── jenkins/                # Jenkins pipeline scripts
├── monitoring/             # Prometheus & Grafana configs
├── docs/                   # Additional documentation
├── package.json            # Node.js dependencies
└── README.md              # This file
```

## 🧪 Testing the Pipeline

1. **Make Code Changes**: Edit application files
2. **Commit & Push**: Push changes to GitHub repository
3. **Monitor Jenkins**: Watch pipeline execution in Jenkins dashboard
4. **Check Security Scans**: Review SonarQube and Trivy reports
5. **Verify Deployment**: Confirm application deployment via ArgoCD
6. **Monitor Performance**: Check Grafana dashboards for metrics

## 🛠️ Troubleshooting

### Common Issues

**Docker Permission Errors**
```bash
sudo usermod -a -G docker jenkins
sudo systemctl restart jenkins
```

**SonarQube Timeout Issues**
- Increase quality gate timeout
- Exclude unnecessary files from scanning
- Ensure adequate server resources

**ArgoCD Sync Issues**
- Verify GitHub repository access
- Check Kubernetes manifest syntax
- Ensure cluster connectivity

**Monitoring Data Missing**
- Verify Prometheus targets are up
- Check security group configurations
- Restart monitoring services if needed

## 📚 Learning Resources

- [Jenkins Documentation](https://www.jenkins.io/doc/)
- [SonarQube Documentation](https://docs.sonarqube.org/)
- [Kubernetes Documentation](https://kubernetes.io/docs/)
- [ArgoCD Documentation](https://argo-cd.readthedocs.io/)
- [Prometheus Documentation](https://prometheus.io/docs/)

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- TMDB for providing the movie database API
- Netflix for design inspiration
- Open source community for the amazing tools used in this project

## 📞 Contact

**Ijeawele Divine Nkwocha**
- LinkedIn: [Your LinkedIn Profile](https://linkedin.com/in/ijeawele-nkwocha)
- GitHub: [Your GitHub Profile](https://github.com/DivineTheAnalyst)
- Email: [Your Email](dnkwocha14@gmail.com)

---

**⚠️ Important**: This project is for educational purposes only. Remember to clean up AWS resources after testing to avoid unexpected charges. The Netflix clone is a demonstration project and not intended for commercial use.
