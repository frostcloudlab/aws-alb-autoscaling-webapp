# aws-alb-autoscaling-webapp

A highly available web application deployed on AWS using an Application Load Balancer, EC2 Auto Scaling, and Amazon EC2 across multiple Availability Zones.

This project demonstrates core AWS infrastructure concepts including traffic distribution, health checks, scaling, and secure instance administration.

## Project Goals

- Build a real AWS compute-based application stack
- Distribute traffic across multiple Availability Zones
- Use an Application Load Balancer to route user traffic
- Maintain healthy instances using Auto Scaling
- Manage EC2 instances without exposing SSH to the internet

## Architecture Overview

User  
→ Application Load Balancer  
→ Target Group  
→ EC2 Auto Scaling Group  
→ EC2 instances (multiple AZs)

## AWS Services Used

- Amazon VPC
- Public subnets (2 AZs)
- Internet Gateway
- Route tables
- Security groups
- Application Load Balancer (ALB)
- Target group
- EC2 launch template
- EC2 Auto Scaling group
- Amazon EC2
- IAM (SSM access)
- AWS Systems Manager Session Manager
- Amazon CloudWatch

## What This Project Demonstrates

- Multi-AZ high availability design
- Layer 7 load balancing with ALB
- Health checks and target groups
- Automatic instance replacement
- Secure administration without SSH
- Basic observability

## Demo Behavior

The application serves a simple web page that displays:

- hostname
- instance ID
- Availability Zone
- deployment version

Refreshing the page shows traffic being handled by different instances behind the load balancer.

## Build Summary

This project is deployed manually in AWS as hands-on infrastructure practice.

Core steps:

1. Create VPC and public subnets
2. Configure Internet Gateway and routing
3. Create security groups
4. Create IAM role for SSM
5. Create launch template with user data
6. Create target group and ALB
7. Create Auto Scaling group
8. Validate health checks and load balancing

## Status

In progress

## Author

Nicholas Frost

GitHub: https://github.com/frostcloudlab  
Portfolio: https://frost.vip
