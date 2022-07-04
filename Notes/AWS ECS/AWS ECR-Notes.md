# AWS ECR-Notes

AWS ECR Concepts

Registry
An AWS ECR private registry is provided to each AWS account; you can create one or more repositories in your registry and store images in them.

Authorization Token
Your client must authenticate to AWS ECR registries as an AWS user before it can push and pull images.

Repository
An AWS ECR repository contains your Docker images, open container images (OCI), and OCI compatible artifacts.

Repository Policy
You can control accesss to your repositories and the images within them with repository polices.

Image
You can push and pull container images to your repositories. You can use these images locally on your development system, or you can use them in the AWS ECS task definitions and AWS EKS pod specifications.

Features of AWS ECR

* You are able to define lifecycle policies to better manage the state of unused images within your ECR repository.
* Image scanning helps in identifying software vulnerabilities in your container images. Each repository can configured to scan on push. This ensures that each new image push to the repository is scanned. You can then retrieve the results of the scan.
* Cross-Region and cross account replication makes it easier for you to have your images where you need them. This is configured as a registry setting and is on a per-region basis.
* Pull through cache rules provides a way to cache repositories in remote public registries in your private AWS ECR registry. Using a pull though cache rule, AWS ECR will periodically reach out to the remote registry to ensure the cached image in your AWS ECR private registry is up to date.