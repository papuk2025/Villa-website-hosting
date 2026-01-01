# 🏠 Villa Website Hosting Project

A complete solution for hosting a beautiful villa website using **AWS S3** and **Terraform** infrastructure as code.

## 🌟 Project Overview

This project demonstrates how to deploy a static villa website to AWS S3 using Terraform. The website showcases luxury properties with a modern, responsive design.

## 🎯 What You'll Get

- ✅ **Live Website**: Fully functional villa property website
- ✅ **AWS S3 Hosting**: Scalable and cost-effective hosting
- ✅ **Infrastructure as Code**: Reproducible deployments with Terraform
- ✅ **Professional Setup**: Production-ready configuration

## 🚀 Quick Start

### Prerequisites
- AWS Account with appropriate permissions
- Terraform installed (version >= 1.0)
- AWS CLI configured

### Deploy in 3 Steps

1. **Clone & Navigate**
   ```bash
   git clone <your-repo-url>
   cd Villa-website-hosting
   ```

2. **Deploy Infrastructure**
   ```bash
   terraform init
   terraform apply
   ```

3. **Access Your Website**
   Visit the URL from the Terraform output!

## 📱 Website Features

- **Responsive Design**: Works on all devices
- **Property Showcase**: Beautiful property listings
- **Contact Forms**: Easy customer communication
- **Modern UI**: Professional villa presentation
- **Fast Loading**: Optimized for performance

## 🏗️ Architecture

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   Your Code     │───▶│   Terraform     │───▶│   AWS S3        │
│   (HTML/CSS/JS) │    │   (IaC)         │    │   (Hosting)     │
└─────────────────┘    └─────────────────┘    └─────────────────┘
```

## 📁 Project Structure

```
Villa-website-hosting/
├── 📄 main.tf              # Terraform configuration
├── 📖 README.md            # This file
├── 📋 README-TERRAFORM.md  # Technical documentation
├── 🏠 index.html           # Homepage
├── 📞 contact.html         # Contact page
├── 🏘️ properties.html      # Properties listing
├── 🏡 property-details.html # Property details
├── 🎨 assets/              # Website assets
│   ├── css/               # Stylesheets
│   ├── js/                # JavaScript
│   ├── images/            # Property images
│   └── webfonts/          # Fonts
└── 📚 vendor/             # Third-party libraries
    ├── bootstrap/         # Bootstrap framework
    └── jquery/            # jQuery library
```

## 🎨 Website Preview

The website includes:
- **Hero Section**: Eye-catching property showcases
- **Property Listings**: Grid layout of available properties
- **Contact Information**: Easy ways to reach out
- **Responsive Navigation**: Mobile-friendly menu
- **Professional Styling**: Modern villa aesthetic

## 🔧 Technical Details

For detailed technical information, see [README-TERRAFORM.md](README-TERRAFORM.md)

## 🛡️ Security & Best Practices

- ✅ **Public Access**: Properly configured for website hosting
- ✅ **Bucket Policies**: Secure read-only access
- ✅ **State Management**: Terraform state excluded from Git
- ✅ **Content Types**: Proper MIME types for all files

## 📊 Costs

- **S3 Storage**: ~$0.023 per GB/month
- **Data Transfer**: ~$0.09 per GB (first 1TB free)
- **Total**: Typically < $1/month for small websites

## 🧹 Cleanup

To remove all resources:
```bash
terraform destroy
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test the deployment
5. Submit a pull request

## 📞 Support

If you encounter any issues:
1. Check the [technical README](README-TERRAFORM.md)
2. Review AWS S3 documentation
3. Open an issue on GitHub

## 📄 License

This project is open source and available under the [MIT License](LICENSE).

---

**Ready to deploy your villa website? Start with `terraform init` and `terraform apply`!** 🚀



