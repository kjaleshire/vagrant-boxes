#### Elasticsearch Notes

This box is special in that it sets up several VMs in tandem which form an Elasticsearch cluster. You can edit the Vagrantfile to only spin up one, or maybe 3 or 5 boxes however you like.

Be careful on the hardware settings. ES requires at *least* 2GB of memory to function or you risk crashing the JVM from not having enough free memory.
