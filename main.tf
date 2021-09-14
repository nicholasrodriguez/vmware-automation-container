terraform {
  required_providers {
    nsxt = {
      source = "vmware/nsxt"
      version = "3.2.4"
    }
    vcd = {
      source = "vmware/vcd"
      version = "3.3.1"
    }
    avi = {
      source = "vmware/avi"
      version = "21.1.1"
    }
  }
}
