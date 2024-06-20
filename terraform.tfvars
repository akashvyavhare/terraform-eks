regions = {
  qa = "us-west-2"
  generic = "us-west-2"
}
use_case = "generic"

cluster_config = {
  qa = {
    manage_aws_auth_configmap = true
    create_aws_auth_configmap = false
    aws_auth_accounts         = ["778122232551"]
    aws_auth_roles = [
      {
        groups   = ["system:masters"]
        username = "system:node:{{EC2PrivateDNSName}}"
        rolearn  = "arn:aws:iam::778122232551:role/admin-bmpd-jenkins-profile-role"
      }
    ]
    aws_auth_users = [
      {
        userarn  = "arn:aws:iam::778122232551:user/vivek@bmpd.com"
        username = "vivek@bmpd.com"
        groups   = ["system:masters"]
      },
      {
        userarn  = "arn:aws:iam::778122232551:user/gaurav@bmpd.com"
        username = "gaurav@bmpd.com"
        groups   = ["system:masters"]
      }
    ]
    cloudwatch_log_group_kms_key_id        = null
    cloudwatch_log_group_retention_in_days = 90
    cluster_additional_security_group_ids  = []
    cluster_encryption_kms_key_policy      = null
    cluster_addons = {
      # coredns = {
      #   resolve_conflicts = "OVERWRITE"
      # }
      kube-proxy = {}
      vpc-cni = {
        resolve_conflicts = "OVERWRITE"
      }
    }
    cluster_enabled_log_types = [
      "audit",
      "api",
      "authenticator"
    ]
    attach_cluster_encryption_policy        = false
    cluster_endpoint_private_access         = true
    cluster_endpoint_public_access          = false
    cluster_endpoint_public_access_cidrs    = ["0.0.0.0/0"]
    cluster_security_group_additional_rules = {}
    cluster_service_ipv4_cidr               = "172.20.0.0/16"
    kms_key_enable_default_policy           = true
    enable_kms_key_rotation                 = true
    kms_key_source_policy_documents         = []
    openid_connect_audiences                = []
    custom_oidc_thumbprints                 = []
    cluster_identity_providers              = {}
    cluster_timeouts = {
      create = "60m"
      update = "60m"
      delete = "60m"
    }
    cluster_version                 = "1.27"
    eks_managed_node_group_defaults = {}
    iam_role_additional_policies    = []
    create_kms_key                  = false
    kms_key_administrators          = []
    kms_key_deletion_window_in_days = 7
    kms_key_owners                  = []
    kms_key_service_users           = []
    kms_key_users                   = []
    node_security_group_additional_rules = {
      1 = {
        type        = "ingress"
        from_port   = 0
        to_port     = 65535
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      }
      2 = {
        type        = "ingress"
        from_port   = 0
        to_port     = 65535
        protocol    = "all"
        cidr_blocks = ["0.0.0.0/0"]
      }
      3 = {
        type        = "egress"
        from_port   = 0
        to_port     = 65535
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      }
    }
    eks_managed_node_groups = {
      primary = {
        ami_id                                = null
        ami_release_version                   = null
        ami_type                              = "AL2_x86_64"
        attach_cluster_primary_security_group = true
        block_device_mappings                 = {}
        capacity_type                         = "ON_DEMAND"
        cluster_version                       = "1.27"
        disable_api_termination               = false
        disk_size                             = 20
        ebs_optimized                         = true
        enable_monitoring                     = true
        force_update_version                  = true
        iam_role_additional_policies = [
          "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
        ]
        instance_types                  = ["t2.large", "t3a.xlarge"]
        labels                          = {}
        launch_template_version         = null
        launch_template_default_version = null
        max_size                        = 10
        min_size                        = 1
        remote_access                   = {}
        security_group_rules            = {}
        taints                          = {}
        timeouts = {
          create = "60m"
          update = "60m"
          delete = "60m"
        }
        update_config          = {}
        vpc_security_group_ids = []
        create_security_group  = true
      }
      # secondary = {
      #   ami_id                                = null
      #   ami_release_version                   = null
      #   ami_type                              = "AL2_x86_64"
      #   attach_cluster_primary_security_group = true
      #   block_device_mappings                 = {}
      #   capacity_type                         = "ON_DEMAND"
      #   cluster_version                       = "1.22"
      #   disable_api_termination               = false
      #   disk_size                             = 20
      #   ebs_optimized                         = true
      #   enable_monitoring                     = true
      #   force_update_version                  = true
      #   iam_role_additional_policies = [
      #     "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
      #   ]
      #   instance_types                  = ["t2.large", "t3a.xlarge"]
      #   labels                          = {}
      #   launch_template_version         = null
      #   launch_template_default_version = null
      #   max_size                        = 10
      #   min_size                        = 1
      #   remote_access                   = {}
      #   security_group_rules            = {}
      #   taints                          = {}
      #   timeouts = {
      #     create = "60m"
      #     update = "60m"
      #     delete = "60m"
      #   }
      #   update_config          = {}
      #   vpc_security_group_ids = []
      # }
      # tertiary = {
      #   ami_id                                = null
      #   ami_release_version                   = null
      #   ami_type                              = "AL2_x86_64"
      #   attach_cluster_primary_security_group = true
      #   block_device_mappings                 = {}
      #   capacity_type                         = "ON_DEMAND"
      #   cluster_version                       = "1.22"
      #   disable_api_termination               = false
      #   disk_size                             = 20
      #   ebs_optimized                         = true
      #   enable_monitoring                     = true
      #   force_update_version                  = true
      #   iam_role_additional_policies = [
      #     "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
      #   ]
      #   instance_types                  = ["t2.large", "t3a.xlarge"]
      #   labels                          = {}
      #   launch_template_version         = null
      #   launch_template_default_version = null
      #   max_size                        = 10
      #   min_size                        = 1
      #   remote_access                   = {}
      #   security_group_rules            = {}
      #   taints                          = {}
      #   timeouts = {
      #     create = "60m"
      #     update = "60m"
      #     delete = "60m"
      #   }
      #   update_config          = {}
      #   vpc_security_group_ids = []
      # }


    }
  }
    generic = {
    manage_aws_auth_configmap = true
    create_aws_auth_configmap = false
    aws_auth_accounts         = ["778122232551"]
    aws_auth_roles = [
      {
        groups   = ["system:masters"]
        username = "system:node:{{EC2PrivateDNSName}}"
        rolearn  = "arn:aws:iam::778122232551:role/admin-bmpd-jenkins-profile-role"
      }
    ]
    aws_auth_users = [
      {
        userarn  = "arn:aws:iam::778122232551:user/atharva@fm"
        username = "atharva@fm"
        groups   = ["system:masters"]
      },
      {
        userarn  = "arn:aws:iam::778122232551:user/gaurav@bmpd.com"
        username = "gaurav@bmpd.com"
        groups   = ["system:masters"]
      },
      {
        userarn  = "arn:aws:iam::778122232551:user/akash@fm"
        username = "akash@fm"
        groups   = ["system:masters"]
      }
    ]
    cloudwatch_log_group_kms_key_id        = null
    cloudwatch_log_group_retention_in_days = 90
    cluster_additional_security_group_ids  = []
    cluster_encryption_kms_key_policy      = null
    cluster_addons = {
      # coredns = {
      #   resolve_conflicts = "OVERWRITE"
      # }
      kube-proxy = {}
      vpc-cni = {
        resolve_conflicts = "OVERWRITE"
      }
    }
    cluster_enabled_log_types = [
      "audit",
      "api",
      "authenticator"
    ]
    attach_cluster_encryption_policy        = false
    cluster_endpoint_private_access         = true
    cluster_endpoint_public_access          = false
    cluster_endpoint_public_access_cidrs    = ["0.0.0.0/0"]
    cluster_security_group_additional_rules = {}
    cluster_service_ipv4_cidr               = "172.20.0.0/16"
    kms_key_enable_default_policy           = true
    enable_kms_key_rotation                 = true
    kms_key_source_policy_documents         = []
    openid_connect_audiences                = []
    custom_oidc_thumbprints                 = []
    cluster_identity_providers              = {}
    cluster_timeouts = {
      create = "60m"
      update = "60m"
      delete = "60m"
    }
    cluster_version                 = "1.30"
    eks_managed_node_group_defaults = {}
    iam_role_additional_policies    = []
    create_kms_key                  = false
    kms_key_administrators          = []
    kms_key_deletion_window_in_days = 7
    kms_key_owners                  = []
    kms_key_service_users           = []
    kms_key_users                   = []
    node_security_group_additional_rules = {
      1 = {
        type        = "ingress"
        from_port   = 0
        to_port     = 65535
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      }
      2 = {
        type        = "ingress"
        from_port   = 0
        to_port     = 65535
        protocol    = "all"
        cidr_blocks = ["0.0.0.0/0"]
      }
      3 = {
        type        = "egress"
        from_port   = 0
        to_port     = 65535
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      }
    }
    eks_managed_node_groups = {
      primary = {
        ami_id                                = null
        ami_release_version                   = null
        ami_type                              = "AL2_x86_64"
        attach_cluster_primary_security_group = true
        block_device_mappings                 = {}
        capacity_type                         = "ON_DEMAND"
        cluster_version                       = "1.30"
        disable_api_termination               = false
        disk_size                             = 20
        ebs_optimized                         = true
        enable_monitoring                     = true
        force_update_version                  = true
        iam_role_additional_policies = [
          "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
        ]
        instance_types                  = ["t2.large", "t3a.xlarge"]
        labels                          = {}
        launch_template_version         = null
        launch_template_default_version = null
        max_size                        = 10
        min_size                        = 1
        remote_access                   = {}
        security_group_rules            = {}
        taints                          = {}
        timeouts = {
          create = "60m"
          update = "60m"
          delete = "60m"
        }
        update_config          = {}
        vpc_security_group_ids = []
        create_security_group  = true
      }
      # secondary = {
      #   ami_id                                = null
      #   ami_release_version                   = null
      #   ami_type                              = "AL2_x86_64"
      #   attach_cluster_primary_security_group = true
      #   block_device_mappings                 = {}
      #   capacity_type                         = "ON_DEMAND"
      #   cluster_version                       = "1.22"
      #   disable_api_termination               = false
      #   disk_size                             = 20
      #   ebs_optimized                         = true
      #   enable_monitoring                     = true
      #   force_update_version                  = true
      #   iam_role_additional_policies = [
      #     "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
      #   ]
      #   instance_types                  = ["t2.large", "t3a.xlarge"]
      #   labels                          = {}
      #   launch_template_version         = null
      #   launch_template_default_version = null
      #   max_size                        = 10
      #   min_size                        = 1
      #   remote_access                   = {}
      #   security_group_rules            = {}
      #   taints                          = {}
      #   timeouts = {
      #     create = "60m"
      #     update = "60m"
      #     delete = "60m"
      #   }
      #   update_config          = {}
      #   vpc_security_group_ids = []
      # }
      # tertiary = {
      #   ami_id                                = null
      #   ami_release_version                   = null
      #   ami_type                              = "AL2_x86_64"
      #   attach_cluster_primary_security_group = true
      #   block_device_mappings                 = {}
      #   capacity_type                         = "ON_DEMAND"
      #   cluster_version                       = "1.22"
      #   disable_api_termination               = false
      #   disk_size                             = 20
      #   ebs_optimized                         = true
      #   enable_monitoring                     = true
      #   force_update_version                  = true
      #   iam_role_additional_policies = [
      #     "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
      #   ]
      #   instance_types                  = ["t2.large", "t3a.xlarge"]
      #   labels                          = {}
      #   launch_template_version         = null
      #   launch_template_default_version = null
      #   max_size                        = 10
      #   min_size                        = 1
      #   remote_access                   = {}
      #   security_group_rules            = {}
      #   taints                          = {}
      #   timeouts = {
      #     create = "60m"
      #     update = "60m"
      #     delete = "60m"
      #   }
      #   update_config          = {}
      #   vpc_security_group_ids = []
      # }


    }
  }

}


