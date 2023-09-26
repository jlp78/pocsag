# pocsag
scripts and tools for working with POCSAG pagers

These scripts are designed to be used with DAPNET (see https://hampager.de/) or
directly on a machine running MMDVMHost (i.e., a pi-star or similar setup).

You will need to customize the DAPNET scripts with your credentials for DAPNET
(i.e. your username/callsign and password) and MMDVM scripts with your personal
RIC (pager identifier).

# dapnet-send.sh

Send a message via DAPNET.

# dapnet_watchdog.sh

Sometimes, the pi-star DAPNETGateway software loses contact with DAPNET.  When
this happens, the "transmitters" page on DAPNET shows either "ERROR" or "OFFLINE"
status.  The pi-star does not detect this problem.

You can run this script from crontab (see below for an example crontab configuration)
periodically.  It will check the transmitters page on DAPNET and if it finds the
transmitter in ERROR or OFFLINE state, it restarts the DAPNETGateway software.

Example crontab:
  */5 * * * * /home/pi-star/dapnet_watchdog.sh >/dev/null 2>&1

# direct-send.sh

Sometimes, you want to send a page WITHOUT depending on the internet or connectivity
with DAPNET.  This script uses RemoteCommand to inject a page directly into the
MMDVMHost software running on the pi-star device.  You will need to know the actual
RIC (Radio Identification Code) as MMDVMHost doesn't know the mapping between
callsigns and RICs.
