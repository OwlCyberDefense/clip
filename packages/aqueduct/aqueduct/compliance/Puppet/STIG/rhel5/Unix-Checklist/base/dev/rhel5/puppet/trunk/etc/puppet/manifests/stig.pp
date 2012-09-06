# Note: this is not the typical puppet site.pp, as it has no nodes.  It
# is meant to be ran interactively using the puppet command.  To use it
# with a puppetmaster, nodes will need to be added.

# default path for exec resources:
Exec { path => "/usr/bin:/usr/sbin:/bin:/sbin" }

##########################################################################
# CNSS-SCC
##########################################################################

###################################
# Access Control

# AC-1: Access Control Policy and Procedures
# Puppet Actions: None - PROCEDURAL REQUIREMENT

# AC-2: Account Management
# Puppet Actions:

        # AC-2(1)
        # Puppet Actions: PROCEDURAL REQUIREMENT

        # AC-2(2)
        # Puppet Actions: PROCEDURAL REQUIREMENT - Sysadmin must create temp accounts correctly

        # AC-2(3)
        # Puppet Actions: PROCEDURAL REQUIREMENT

        # AC-2(4)
        # Puppet Actions: PROCEDURAL REQUIREMENT

        # AC-2(5)
        # Puppet Actions: PROCEDURAL REQUIREMENT

# AC-3: Access Enforcement
# Puppet Actions:
import "AC-3"

        # AC-3(1)
        # Puppet Actions:

                include ac-3::p1

        # AC-3(2)
        # Puppet Actions: No actions required

        # AC-3(3)
        # Puppet Actions: NOT REQUIRED BY NSS DOCUMENT

        # AC-3(4)
        # Puppet Actions: (Not required)

                include ac-3::p4

# AC-4: Information Flow Enforcement
# Puppet Actions:

        # AC-4(2)
        # Puppet Actions: None Requiered - Needs Installer Review (site specific policy)

# AC-5: Separation of Duties
# Puppet Actions: None Required - PROCEDURAL REQUIREMENT

# AC-6: Least Privilege
# Puppet Actions:

        # AC-6(1)
        # Puppet Actions: PROCEDURAL REQUIREMENT

# AC-7: Unsuccessful Login Attempts
# Puppet Actions:
import "AC-7"

        # AC-7(1)
        # Puppet Actions:
                # 3 login attempts in 30 seconds; lock out for 1 minute
                ac-7::p1 { "login_attempts":
                        failed_attempts => "3",
                        deny_interval => "30",
                        lockout_time => "60"
                }

# AC-8: System Use Notification
# Puppet Actions:
import "AC-8"

        include ac-8::main

# AC-9: Previous Logon Notification
# Puppet Actions: None Required

# AC-10: Concurrent Session Control
# Puppet Actions: FIXME: Needs further attention - limit concurrent sessions to 3

# AC-11: Session Lock
# Puppet Actions:
import "AC-11"

        # AC-11(1)
        # Puppet Actions:

        include ac-11::p1

# AC-12: Session Termination
# Puppet Actions:

        # AC-12(1)
        # Puppet Actions:

                # Implemented in AC-11(1)

        # AC-12(2)
        # Puppet Actions:

                # Implemented in AC-11(1)

# AC-13: Supervision and ReviewâAccess Control
# Puppet Actions:

        # AC-13(1)
        # Puppet Actions: None Required - Needs Installer Review

# AC-14: Permitted Actions without Identification or Authentication
# Puppet Actions: None - PROCEDURAL REQUIREMENT

        # AC-14(1)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

# AC-15: Automated Marking
# Puppet Actions:
import "AC-15"

        include ac-15::main

        # AC-15(1)
        # See AC-15

# AC-16: Automated Labeling
# Puppet Actions: None

# AC-17: Remote Access
# Puppet Actions:
import "AC-17"

        # AC-17(1)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # AC-17(2)
        # Puppet Actions:

                include ac-17::p2

        # AC-17(3)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # AC-17(4)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # AC-17(5)
        # Puppet Actions:

                include ac-17::p5

        # AC-17(6)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # AC-17(7)
        # Puppet Actions:

                include ac-17::p7

# AC-18: Wireless Access Restrictions
# Puppet Actions: None - PROCEDURAL REQUIREMENT

        # AC-18(1)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # AC-18(2)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # AC-18(3)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # AC-18(4)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # AC-18(5)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

# AC-19: Access Control for Portable and Mobile Devices
# Puppet Actions: None - PROCEDURAL REQUIREMENT

        # AC-19(1)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

# AC-20: Use of External Information Systems
# Puppet Actions: None - PROCEDURAL REQUIREMENT

        # AC-20(1)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

# AC-21: Confidentiality of Data at Rest
# Puppet Actions:

        # FIXME: Point out full disk encryption available.
        # This is only when desired by information owner.
        # Not required for all cases.

# AC-22: Distinct Level of Access
# Puppet Actions: None - PROCEDURAL REQUIREMENT

# AC-23: User Based Collaboration and Information Sharing Control
# Puppet Actions: None - PROCEDURAL REQUIREMENT

###################################
# Awareness and Training

# AT-1: Security Awareness and Training Policy and Procedures
# Puppet Actions: None - PROCEDURAL REQUIREMENT

# AT-2: Security Awareness
# Puppet Actions: None - PROCEDURAL REQUIREMENT

# AT-3: Security Training
# Puppet Actions: None - PROCEDURAL REQUIREMENT

# AT-4: Security Training Records
# Puppet Actions: None - PROCEDURAL REQUIREMENT

# AT-5: Contacts with Security Groups and Associations
# Puppet Actions: None - PROCEDURAL REQUIREMENT

# AT-6: Certifier Training by Developers
# Puppet Actions: None - PROCEDURAL REQUIREMENT


###################################
# Audit and Accountability

# AU-1: Audit and Accountability Policy and Procedures
# Puppet Actions: None - PROCEDURAL REQUIREMENT

        # AU-1(1)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

# AU-2: Auditable Events
# Puppet Actions: None Required - Installer responsible for ensuring organization defined audits happen
import "AU-2"

        # AU-2(1)
        # Puppet Actions:

                include au-2::p1

        # AU-2(2)
        # Puppet Actions: None Required (see auditd conf files)

        # AU-2(3)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # AU-2(4)
        # Puppet Actions:

                # implemented in AU-2(1)

        # AU-2(5)
        # Puppet Actions: NOT REQUIRED BY NSS DOCUMENT - capability present in RHEL5.3 audit subsystem

        # AU-2(6)
        # Puppet Actions: NOT REQUIRED BY NSS DOCUMENT

        # AU-2(7)
        # Puppet Actions: NOT REQUIRED BY NSS DOCUMENT

        # AU-2(8)
        # Puppet Actions: NOT REQUIRED BY NSS DOCUMENT

        # AU-2(9)
        # Puppet Actions: NOT REQUIRED BY NSS DOCUMENT

        # AU-2(10)
        # Puppet Actions: NOT REQUIRED BY NSS DOCUMENT

# AU-3: Content of Audit Records
# Puppet Actions:

        # AU-3(1)
        # Puppet Actions: No Actions Required

        # AU-3(2)
        # Puppet Actions: No Actions Required

        # AU-3(3)
        # Puppet Actions: No Actions Required

        # AU-3(4)
        # Puppet Actions:

                # Implemented in AU-2(1)

        # AU-3(5)
        # Puppet Actions: NOT REQUIRED BY NSS DOCUMENT

# AU-4: Audit Storage Capacity
# Puppet Actions: None - PROCEDURAL REQUIREMENT

# AU-5: Response to Audit Processing Failures
# Puppet Actions:

        # AU-5(1)
        # Puppet Actions:

                # Implemented in AU-2(1)

        # AU-5(2)
        # Puppet Actions: PROCEDURAL - Org defined audit failure events required to perform  real time alert.

        # AU-5(3)
        # Puppet Actions:

                # Implemented in AU-2(1)

# AU-6: Audit Monitoring, Analysis, and Reporting
# Puppet Actions:

        # AU-6(1)
        # Puppet Actions: No Actions Required

        # AU-6(2)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # AU-6(3)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # AU-6(4)
        # Puppet Actions: NOT REQUIRED BY NSS DOCUMENT

        # AU-6(5)
        # Puppet Actions: NOT REQUIRED BY NSS DOCUMENT

# AU-7: Audit Reduction and Report Generation
# Puppet Actions:

        # AU-7(1)
        # Puppet Actions: None - Site should decide on and install tool

        # AU-7(2)
        # Puppet Actions: None - Site should decide on and install tool

# AU-8: Time Stamps
# Puppet Actions:

        # AU-8(1)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # AU-8(2)
        # Puppet Actions: NOT REQUIRED BY NSS DOCUMENT

# AU-9: Protection of Audit Information
# Puppet Actions:

        # implemented in AU-2(1)

        # AU-9(1)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # AU-9(2)
        # Puppet Actions: NOT REQUIRED BY NSS DOCUMENT

# AU-10: Non-repudiation
# Puppet Actions: None - PROCEDURAL REQUIREMENT

        # AU-10(1)
        # Puppet Actions: NOT REQUIRED BY NSS DOCUMENT

        # AU-10(2)
        # Puppet Actions: NOT REQUIRED BY NSS DOCUMENT

        # AU-10(3)
        # Puppet Actions: NOT REQUIRED BY NSS DOCUMENT

        # AU-10(4)
        # Puppet Actions: NOT REQUIRED BY NSS DOCUMENT

# AU-11: Audit Record Retention
# Puppet Actions: None - PROCEDURAL REQUIREMENT

        # AU-11(1)
        # Puppet Actions: NOT REQUIRED BY NSS DOCUMENT

        # AU-11(2)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # AU-11(3)
        # Puppet Actions: NOT REQUIRED BY NSS DOCUMENT

        # AU-11(4)
        # Puppet Actions: NOT REQUIRED BY NSS DOCUMENT

# AU-12: Session Audit
# Puppet Actions: Has legal ramifications - implement with legal guidance

        # AU-12(1)
        # Puppet Actions: NOT REQUIRED BY NSS DOCUMENT

        # AU-12(2)
        # Puppet Actions: NOT REQUIRED BY NSS DOCUMENT


###################################
# Certification, Accreditation, and Security Assessments

# CA-1: Certification, Accreditation, and Security Assessment Policies and Procedures
# Puppet Actions: None - PROCEDURAL REQUIREMENT

# CA-2: Security Assessments
# Puppet Actions: None - PROCEDURAL REQUIREMENT

# CA-3: Information System Connections
# Puppet Actions: None - PROCEDURAL REQUIREMENT

# CA-4: Security Certification
# Puppet Actions: None - PROCEDURAL REQUIREMENT

        # CA-4(1)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # CA-4(2)
        # Puppet Actions: NOT REQUIRED BY NSS DOCUMENT

        # CA-4(3)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

# CA-5: Plan of Action and Milestones
# Puppet Actions: None - PROCEDURAL REQUIREMENT

# CA-6: Security Accreditation
# Puppet Actions: None - PROCEDURAL REQUIREMENT

# CA-7: Continuous Monitoring
# Puppet Actions: None - PROCEDURAL REQUIREMENT

        # CA-7(1)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # CA-7(2)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT


###################################
# Configuration Management

# CM-1: Configuration Management Policy and Procedures
# Puppet Actions: None - PROCEDURAL REQUIREMENT

# CM-2: Baseline Configuration
# Puppet Actions: None - PROCEDURAL REQUIREMENT

        # CM-2(1)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # CM-2(2)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # CM-2(3)
        # Puppet Actions: NOT REQUIRED BY NSS DOCUMENT

        # CM-2(4)
        # Puppet Actions: NOT REQUIRED BY NSS DOCUMENT

# CM-3: Configuration Change Control
# Puppet Actions: None - PROCEDURAL REQUIREMENT

        # CM-3(1)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # CM-3(2)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # CM-3(3)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

# CM-4: Monitoring Configuration Changes
# Puppet Actions: None - PROCEDURAL REQUIREMENT

# CM-5: Access Restrictions for Change
# Puppet Actions: None - PROCEDURAL REQUIREMENT

        # CM-5(1)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # CM-5(2)
        # Puppet Actions: NOT REQUIRED BY NSS DOCUMENT

        # CM-5(3)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # CM-5(4)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

# CM-6: Configuration Settings
# Puppet Actions: None - PROCEDURAL REQUIREMENT

        # CM-6(1)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # CM-6(2)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

# CM-7: Least Functionality
# Puppet Actions: None - PROCEDURAL REQUIREMENT

        # CM-7(1)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # CM-7(2)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

# CM-8: Information System Component Inventory
# Puppet Actions: None - PROCEDURAL REQUIREMENT

        # CM-8(1)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # CM-8(2)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT


###################################
# Contingency Planning

# CP-1: Contingency Planning Policy and Procedures
# Puppet Actions: None - PROCEDURAL REQUIREMENT

        # CP-1(1)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

# CP-2: Contingency Plan
# Puppet Actions: None - PROCEDURAL REQUIREMENT

        # CP-2(1)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # CP-2(2)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # CP-2(3)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # CP-2(4)
        # Puppet Actions: NOT REQUIRED BY NSS DOCUMENT

        # CP-2(5)
        # Puppet Actions: NOT REQUIRED BY NSS DOCUMENT

        # CP-2(6)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # CP-2(7)
        # Puppet Actions: NOT REQUIRED BY NSS DOCUMENT

# CP-3: Contingency Training
# Puppet Actions: None - PROCEDURAL REQUIREMENT

        # CP-3(1)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # CP-3(2)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

# CP-4: Contingency Plan Testing and Exercises
# Puppet Actions: None - PROCEDURAL REQUIREMENT

        # CP-4(1)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # CP-4(2)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # CP-4(3)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # CP-4(4)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

# CP-5: Contingency Plan Update
# Puppet Actions: None - PROCEDURAL REQUIREMENT

# CP-6: Alternate Storage Site
# Puppet Actions: None - PROCEDURAL REQUIREMENT

        # CP-6(1)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # CP-6(2)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # CP-6(3)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # CP-6(4)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # CP-6(5)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # CP-6(6)
        # Puppet Actions: NOT REQUIRED BY NSS DOCUMENT

# CP-7: Alternate Processing Site
# Puppet Actions: None - PROCEDURAL REQUIREMENT

        # CP-7(1)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # CP-7(2)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # CP-7(3)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # CP-7(4)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # CP-7(5)
        # Puppet Actions: NOT REQUIRED BY NSS DOCUMENT

        # CP-7(6)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

# CP-8: Telecommunications Services
# Puppet Actions: None - PROCEDURAL REQUIREMENT

        # CP-8(1)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # CP-8(2)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # CP-8(3)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # CP-8(4)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

# CP-9: Information System Backup
# Puppet Actions: None - PROCEDURAL REQUIREMENT

        # CP-9(1)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # CP-9(2)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # CP-9(3)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # CP-9(4)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

# CP-10: Information System Recovery and Reconstitution Identification and Authentication
# Puppet Actions: None - PROCEDURAL REQUIREMENT

        # CP-10(1)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # CP-10(2)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # CP-10(3)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT


###################################
# Identification and Authentication

# IA-1: Identification and Authentication Policy and Procedures
# Puppet Actions: None - PROCEDURAL REQUIREMENT

# IA-2: User Identification and Authentication
# Puppet Actions:
import "IA-2"

        include ia-2::main

        # IA-2(1)
        # Puppet Actions: NOT REQUIRED BY NSS DOCUMENT

        # IA-2(2)
        # Puppet Actions: NOT REQUIRED BY NSS DOCUMENT

        # IA-2(3)
        # Puppet Actions: None - Site specific (Site needs to set up 2 factor system)

        # IA-2(4)
        # Puppet Actions: NOT REQUIRED BY NSS DOCUMENT

        # IA-2(5)
        # Puppet Actions: NOT REQUIRED BY NSS DOCUMENT

        # IA-2(6)
        # Puppet Actions: None - Site specific (Site needs to set up 2 factor system)

        # IA-2(7)
        # Puppet Actions: NOT REQUIRED BY NSS DOCUMENT

        # IA-2(8)
        # Puppet Actions: None - (No default use of certificates)

        # IA-2(9)
        # Puppet Actions: None - (No default use of group authenticators)

# IA-3: Device Identification and Authentication
# Puppet Actions: None - Site Specific

        # IA-3(1)
        # Puppet Actions: NOT REQUIRED BY NSS DOCUMENT

        # IA-3(2)
        # Puppet Actions: None - Site Specific

# IA-4: Identifier Management
# Puppet Actions: None - PROCEDURAL REQUIREMENT

        # IA-4(1)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # IA-4(2)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # IA-4(3)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # IA-4(4)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

# IA-5: Authenticator Management
# Puppet Actions: None - PROCEDURAL REQUIREMENT

        # IA-5(1)
        # Puppet Actions:

                # Implemented in AC-7(1)
                # Implemented in AC-11(1)
                # Implemented in AC-17(7)
                # Implemented in IA-2

        # IA-5(2)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # IA-5(3)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # IA-5(4)
        # Puppet Actions: None if not using PKI

        # IA-5(5)
        # Puppet Actions: NOT REQUIRED BY NSS DOCUMENT

# IA-6: Authenticator Feedback
# Puppet Actions: None Required

# IA-7: Cryptographic Module Authentication
# Puppet Actions: None - PROCEDURAL REQUIREMENT


###################################
# Incident Response

# IR-1: Incident Response Policy and Procedures
# Puppet Actions: None - PROCEDURAL REQUIREMENT

        # IR-1(1)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

# IR-2: Incident Response Training
# Puppet Actions: None - PROCEDURAL REQUIREMENT

        # IR-2(1)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # IR-2(2)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

# IR-3: Incident Response Testing and Exercises
# Puppet Actions: None - PROCEDURAL REQUIREMENT

        # IR-3(1)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # IR-3(2)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

# IR-4: Incident Handling
# Puppet Actions: None - PROCEDURAL REQUIREMENT

        # IR-4(1)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

# IR-5: Incident Monitoring
# Puppet Actions: None - PROCEDURAL REQUIREMENT

        # IR-5(1)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

# IR-6: Incident Reporting
# Puppet Actions: None - PROCEDURAL REQUIREMENT

        # IR-6(1)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

# IR-7: Incident Response Assistance
# Puppet Actions: None - PROCEDURAL REQUIREMENT

        # IR-7(1)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT


###################################
# Maintenance

# MA-1: System Maintenance Policy and Procedures
# Puppet Actions: None - PROCEDURAL REQUIREMENT

# MA-2: Controlled Maintenance
# Puppet Actions: None - PROCEDURAL REQUIREMENT

        # MA-2(1)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # MA-2(2)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

# MA-3: Maintenance Tools
# Puppet Actions: None - PROCEDURAL REQUIREMENT

        # MA-3(1)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # MA-3(2)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # MA-3(3)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # MA-3(4)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

# MA-4: Remote Maintenance
# Puppet Actions: None - PROCEDURAL REQUIREMENT

        # MA-4(1)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # MA-4(2)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # MA-4(3)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # MA-4(4)
        # Puppet Actions: NOT REQUIRED BY NSS DOCUMENT

        # MA-4(5)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # MA-4(4)
        # Puppet Actions: NOT REQUIRED BY NSS DOCUMENT

# MA-5: Maintenance Personnel
# Puppet Actions: None - PROCEDURAL REQUIREMENT

        # MA-5(1)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # MA-5(2)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # MA-5(3)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # MA-5(4)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # MA-5(5)
        # Puppet Actions: NOT REQUIRED BY NSS DOCUMENT

# MA-6: Timely Maintenance
# Puppet Actions: None - PROCEDURAL REQUIREMENT

        # MA-6(1)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # MA-6(2)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT


###################################
# Media Protection

# MP-1: Media Protection Policy and Procedures
# Puppet Actions: None - PROCEDURAL REQUIREMENT

# MP-2: Media Access
# Puppet Actions: None - PROCEDURAL REQUIREMENT

        # MP-2(1)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

# MP-3: Media Labeling
# Puppet Actions: None - PROCEDURAL REQUIREMENT

        # MP-3(1)
        # See AC-15

# MP-4: Media Storage
# Puppet Actions: None - PROCEDURAL REQUIREMENT

        # MP-4(1)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # MP-4(1)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

# MP-5: Media Transport
# Puppet Actions: None - PROCEDURAL REQUIREMENT

        # MP-5(1)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # MP-5(2)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # MP-5(3)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # MP-5(4)
        # Puppet Actions: NOT REQUIRED BY NSS DOCUMENT

# MP-6: Media Sanitization and Disposal
# Puppet Actions: None - PROCEDURAL REQUIREMENT

        # MP-6(1)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # MP-6(2)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # MP-6(3)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # MP-6(4)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT


###################################
# Physical and Environmental Protection

# PE-1: Physical and Environmental Protection Policy and Procedures
# Puppet Actions: None - PROCEDURAL REQUIREMENT

# PE-2: Physical Access Authorizations
# Puppet Actions: None - PROCEDURAL REQUIREMENT

        # PE-2(1)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # PE-2(2)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

# PE-3: Physical Access Control
# Puppet Actions: None - PROCEDURAL REQUIREMENT

        # PE-3(1)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # PE-3(2)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # PE-3(3)
        # Puppet Actions: NOT REQUIRED BY NSS DOCUMENT

        # PE-3(4)
        # Puppet Actions: NOT REQUIRED BY NSS DOCUMENT

# PE-4: Access Control for Transmission Medium
# Puppet Actions: None - PROCEDURAL REQUIREMENT

# PE-5: Access Control for Display Medium
# Puppet Actions: None - PROCEDURAL REQUIREMENT

# PE-6: Monitoring Physical Access
# Puppet Actions: None - PROCEDURAL REQUIREMENT

        # PE-6(1)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # PE-6(2)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

# PE-7: Visitor Control
# Puppet Actions: None - PROCEDURAL REQUIREMENT

        # PE-7(1)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # PE-7(2)
        # Puppet Actions: NOT REQUIRED BY NSS DOCUMENT

# PE-8: Access Records
# Puppet Actions: None - PROCEDURAL REQUIREMENT

        # PE-8(1)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # PE-8(2)
        # Puppet Actions: NOT REQUIRED BY NSS DOCUMENT

# PE-9: Power Equipment and Power Cabling
# Puppet Actions: None - PROCEDURAL REQUIREMENT

        # PE-9(1)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # PE-9(2)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

# PE-10: Emergency Shutoff
# Puppet Actions: None - PROCEDURAL REQUIREMENT

        # PE-10(1)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

# PE-11: Emergency Power
# Puppet Actions: None - PROCEDURAL REQUIREMENT

        # PE-11(1)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # PE-11(2)
        # Puppet Actions: NOT REQUIRED BY NSS DOCUMENT

# PE-12: Emergency Lighting
# Puppet Actions: None - PROCEDURAL REQUIREMENT

        # PE-12(1)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

# PE-13: Fire Protection
# Puppet Actions: None - PROCEDURAL REQUIREMENT

        # PE-13(1)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # PE-13(2)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # PE-13(3)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # PE-13(4)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

# PE-14: Temperature and Humidity Controls
# Puppet Actions: None - PROCEDURAL REQUIREMENT

        # PE-14(1)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

# PE-15: Water Damage Protection
# Puppet Actions: None - PROCEDURAL REQUIREMENT

        # PE-15(1)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

# PE-16: Delivery and Removal
# Puppet Actions: None - PROCEDURAL REQUIREMENT

# PE-17: Alternate Work Site
# Puppet Actions: None - PROCEDURAL REQUIREMENT

# PE-18: Location of Information System Components
# Puppet Actions: None - PROCEDURAL REQUIREMENT

        # PE-18(1)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

# PE-19: Information Leakage Planning
# Puppet Actions: None - PROCEDURAL REQUIREMENT

        # PE-19(1)
        # Puppet Actions: NOT REQUIRED BY NSS DOCUMENT

# PE-20: Physical Security
# Puppet Actions: None - PROCEDURAL REQUIREMENT

        # PE-20(1)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # PE-20(2)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # PE-20(3)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

# PE-21: Environmental Control Training
# Puppet Actions: None - PROCEDURAL REQUIREMENT


###################################
# Planning

# PL-1: Security Planning Policy and Procedures
# Puppet Actions: None - PROCEDURAL REQUIREMENT

# PL-2: System Security Plan
# Puppet Actions: None - PROCEDURAL REQUIREMENT

        # PL-2(1)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # PL-2(2)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # PL-2(3)
        # Puppet Actions: NOT REQUIRED BY NSS DOCUMENT

# PL-3: System Security Plan Update
# Puppet Actions: None - PROCEDURAL REQUIREMENT

# PL-4: Rules of Behavior
# Puppet Actions: None - PROCEDURAL REQUIREMENT

# PL-5: Privacy Impact Assessment
# Puppet Actions: None - PROCEDURAL REQUIREMENT

# PL-6: Security-Related Activity Planning
# Puppet Actions: None - PROCEDURAL REQUIREMENT


###################################
# Personnel Security

# PS-1: Personnel Security Policy and Procedures
# Puppet Actions: None - PROCEDURAL REQUIREMENT

# PS-2: Position Categorization
# Puppet Actions: None - PROCEDURAL REQUIREMENT

# PS-3: Personnel Screening
# Puppet Actions: None - PROCEDURAL REQUIREMENT

        # PS-2(1)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # PS-2(2)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

# PS-4: Personnel Termination
# Puppet Actions: None - PROCEDURAL REQUIREMENT

# PS-5: Personnel Transfer
# Puppet Actions: None - PROCEDURAL REQUIREMENT

# PS-6: Access Agreements
# Puppet Actions: None - PROCEDURAL REQUIREMENT

        # PS-6(1)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # PS-6(2)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

# PS-7: Third-Party Personnel Security
# Puppet Actions: None - PROCEDURAL REQUIREMENT

        # PS-7(1)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

# PS-8: Personnel Sanctions
# Puppet Actions: None - PROCEDURAL REQUIREMENT


###################################
# Risk Assessment

# RA-1: Risk Assessment Policy and Procedures
# Puppet Actions: None - PROCEDURAL REQUIREMENT

# RA-2: Security Categorization
# Puppet Actions: None - PROCEDURAL REQUIREMENT

# RA-3: Risk Assessment
# Puppet Actions: None - PROCEDURAL REQUIREMENT

# RA-4: Risk Assessment Update
# Puppet Actions: None - PROCEDURAL REQUIREMENT

# RA-5: Vulnerability Scanning
# Puppet Actions: None - PROCEDURAL REQUIREMENT

        # RA-5(1)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # RA-5(2)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # RA-5(3)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # RA-5(4)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # RA-5(5)
        # Puppet Actions: NOT REQUIRED BY NSS DOCUMENT


###################################
# System and Services Acquisition

# SA-1: System and Services Acquisition Policy and Procedures
# Puppet Actions: None - PROCEDURAL REQUIREMENT

# SA-2: Allocation of Resources
# Puppet Actions: None - PROCEDURAL REQUIREMENT

# SA-3: Life Cycle Support
# Puppet Actions: None - PROCEDURAL REQUIREMENT

# SA-4: Acquisitions
# Puppet Actions: None - PROCEDURAL REQUIREMENT

        # SA-4(1)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # SA-4(2)
        # Puppet Actions: NOT REQUIRED BY NSS DOCUMENT

        # SA-4(3)
        # Puppet Actions: NOT REQUIRED BY NSS DOCUMENT

        # SA-4(4)
        # Puppet Actions: NOT REQUIRED BY NSS DOCUMENT

        # SA-4(5)
        # Puppet Actions: NOT REQUIRED BY NSS DOCUMENT

        # SA-4(6)
        # Puppet Actions: NOT REQUIRED BY NSS DOCUMENT

        # SA-4(7)
        # Puppet Actions: NOT REQUIRED BY NSS DOCUMENT

        # SA-4(8)
        # Puppet Actions: NOT REQUIRED BY NSS DOCUMENT

# SA-5: Information System Documentation
# Puppet Actions: None - PROCEDURAL REQUIREMENT

        # SA-5(1)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # SA-5(2)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # SA-5(3)
        # Puppet Actions: NOT REQUIRED BY NSS DOCUMENT

        # SA-5(4)
        # Puppet Actions: NOT REQUIRED BY NSS DOCUMENT

        # SA-5(5)
        # Puppet Actions: NOT REQUIRED BY NSS DOCUMENT

        # SA-5(6)
        # Puppet Actions: NOT REQUIRED BY NSS DOCUMENT

        # SA-5(7)
        # Puppet Actions: NOT REQUIRED BY NSS DOCUMENT

# SA-6: Software Usage Restrictions
# Puppet Actions: None - PROCEDURAL REQUIREMENT

        # SA-6(1)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # SA-6(2)
        # Puppet Actions: NOT REQUIRED BY NSS DOCUMENT

# SA-7: User Installed Software
# Puppet Actions: None - PROCEDURAL REQUIREMENT

# SA-8: Security Engineering Principles
# Puppet Actions: None - PROCEDURAL REQUIREMENT

# SA-9: External Information System Services
# Puppet Actions: None - PROCEDURAL REQUIREMENT

        # SA-9(1)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

# SA-10: Developer Configuration Management
# Puppet Actions: None - PROCEDURAL REQUIREMENT

        # SA-10(1)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

# SA-11: Developer Security Testing
# Puppet Actions: None - PROCEDURAL REQUIREMENT

        # SA-11(1)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # SA-11(2)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # SA-11(3)
        # Puppet Actions: NOT REQUIRED BY NSS DOCUMENT

# SA-12: Special Acquisitions - Supply Chain Risk and Defense in Breadth
# Puppet Actions: None - PROCEDURAL REQUIREMENT

        # SA-11(1)
        # Puppet Actions: NOT REQUIRED BY NSS DOCUMENT

        # SA-11(2)
        # Puppet Actions: NOT REQUIRED BY NSS DOCUMENT

        # SA-11(3)
        # Puppet Actions: NOT REQUIRED BY NSS DOCUMENT

        # SA-11(4)
        # Puppet Actions: NOT REQUIRED BY NSS DOCUMENT

        # SA-11(5)
        # Puppet Actions: NOT REQUIRED BY NSS DOCUMENT


###################################
# System and Communications Protection

# SC-1: System and Communications Protection Policy and Procedures
# Puppet Actions: None - PROCEDURAL REQUIREMENT

        # SC-1(1)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

# SC-2: Application Partitioning
# Puppet Actions:

# SC-3: Security Function Isolation
# Puppet Actions: None - PROCEDURAL REQUIREMENT

        # SC-3(1)
        # Puppet Actions: NOT REQUIRED BY NSS DOCUMENT

        # SC-3(2)
        # Puppet Actions: NOT REQUIRED BY NSS DOCUMENT

        # SC-3(3)
        # Puppet Actions: NOT REQUIRED BY NSS DOCUMENT

        # SC-3(4)
        # Puppet Actions: NOT REQUIRED BY NSS DOCUMENT

        # SC-3(5)
        # Puppet Actions: NOT REQUIRED BY NSS DOCUMENT

# SC-4: Information Remnance
# Puppet Actions: FIXME: Verify none required (Might require zero-filling memory pages before handing to user)

# SC-5: Denial of Service Protection
# Puppet Actions: None - PROCEDURAL REQUIREMENT
import "SC-5"

        # SC-5(1)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # SC-5(2)
        # Puppet Actions:

                include sc-5::p2

        # SC-5(3)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

# SC-6: Resource Priority
# Puppet Actions: None - PROCEDURAL REQUIREMENT

# SC-7: Boundary Protection
# Puppet Actions: None - PROCEDURAL REQUIREMENT

        # SC-7(1)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # SC-7(2)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # SC-7(3)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # SC-7(4)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # SC-7(5)
        # Puppet Actions:

                # Implemented in AC-17(5)

        # SC-7(6)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # SC-7(7)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # SC-7(8)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # SC-7(9)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

# SC-8: Transmission Integrity
# Puppet Actions: None - PROCEDURAL REQUIREMENT

        # SC-8(1)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # SC-8(2)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

# SC-9: Transmission Confidentiality
# Puppet Actions:

        # Implemented in AC-17(2) / AC-17(5)

        # SC-9(1)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # SC-9(2)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # SC-9(3)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # SC-9(4)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # SC-9(5)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

# SC-10: Network Disconnect
# Puppet Actions: None Required

# SC-11: Trusted Path
# Puppet Actions: None - PROCEDURAL REQUIREMENT

# SC-12: Cryptographic Key Establishment and Management
# Puppet Actions: None - PROCEDURAL REQUIREMENT

        # SC-12(1)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # SC-12(2)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # SC-12(3)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # SC-12(4)
        # Puppet Actions: NOT REQUIRED BY NSS DOCUMENT

# SC-13: Use of Cryptography
# Puppet Actions: None - PROCEDURAL REQUIREMENT

# SC-14: Public Access Protections
# Puppet Actions: None - PROCEDURAL REQUIREMENT

# SC-15: Collaborative Computing
# Puppet Actions: None - PROCEDURAL REQUIREMENT

        # SC-15(1)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # SC-15(2)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # SC-15(3)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

# SC-16: Transmission of Security Parameters
# Puppet Actions: None - PROCEDURAL REQUIREMENT

        # SC-16(1)
        # Puppet Actions: NOT REQUIRED BY NSS DOCUMENT

        # SC-16(2)
        # Puppet Actions: NOT REQUIRED BY NSS DOCUMENT

# SC-17: Public Key Infrastructure Certificates
# Puppet Actions: None - PROCEDURAL REQUIREMENT

# SC-18: Mobile Code
# Puppet Actions: None - PROCEDURAL REQUIREMENT

        # SC-18(1)
        # Puppet Actions: NOT REQUIRED BY NSS DOCUMENT

        # SC-18(2)
        # Puppet Actions: NOT REQUIRED BY NSS DOCUMENT

# SC-19: Voice Over Internet Protocol
# Puppet Actions: None - PROCEDURAL REQUIREMENT

# SC-20: Secure Name /Address Resolution Service (Authoritative Source)
# Puppet Actions: None - PROCEDURAL REQUIREMENT

        # SC-20(1)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

# SC-21: Secure Name /Address Resolution Service (Recursive or Caching Resolver)
# Puppet Actions:

        # SC-21(1)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

# SC-22: Architecture and Provisioning for Name/Address Resolution Service
# Puppet Actions: None - PROCEDURAL REQUIREMENT

# SC-23: Session Authenticity
# Puppet Actions: None - PROCEDURAL REQUIREMENT


###################################
# System and Information Integrity

# SI-1: System and Information Integrity Policy and Procedures
# Puppet Actions: None - PROCEDURAL REQUIREMENT

# SI-2: Flaw Remediation
# Puppet Actions: None - PROCEDURAL REQUIREMENT

        # SI-2(1)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # SI-2(2)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # SI-2(3)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

# SI-3: Malicious Code Protection
# Puppet Actions: None - PROCEDURAL REQUIREMENT

        # SI-3(1)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # SI-3(2)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # SI-3(3)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # SI-3(4)
        # Puppet Actions: NOT REQUIRED BY NSS DOCUMENT

        # SI-3(5)
        # Puppet Actions: NOT REQUIRED BY NSS DOCUMENT

        # SI-3(6)
        # Puppet Actions: NOT REQUIRED BY NSS DOCUMENT

        # SI-3(7)
        # Puppet Actions: NOT REQUIRED BY NSS DOCUMENT

        # SI-3(8)
        # Puppet Actions: NOT REQUIRED BY NSS DOCUMENT

# SI-4: Information System Monitoring Tools and Techniques
# Puppet Actions: None - PROCEDURAL REQUIREMENT

        # SI-4(1)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # SI-4(2)
        # Puppet Actions: NOT REQUIRED BY NSS DOCUMENT

        # SI-4(3)
        # Puppet Actions: NOT REQUIRED BY NSS DOCUMENT

        # SI-4(4)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # SI-4(5)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # SI-4(6)
        # Puppet Actions: NOT REQUIRED BY NSS DOCUMENT

        # SI-4(7)
        # Puppet Actions: None - Depends on installed tools

        # SI-4(8)
        # Puppet Actions: NOT REQUIRED BY NSS DOCUMENT

# SI-5: Security Alerts and Advisories
# Puppet Actions: None - PROCEDURAL REQUIREMENT

        # SI-5(1)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

# SI-6: Security Functionality Verification
# Puppet Actions: None - PROCEDURAL REQUIREMENT

        # SI-6(1)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # SI-6(2)
        # Puppet Actions: NOT REQUIRED BY NSS DOCUMENT

# SI-7: Software and Information Integrity
# Puppet Actions: None - PROCEDURAL REQUIREMENT

        # SI-7(1)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # SI-7(2)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # SI-7(3)
        # Puppet Actions: NOT REQUIRED BY NSS DOCUMENT

# SI-8: Spam Protection
# Puppet Actions: None - PROCEDURAL REQUIREMENT

        # SI-8(1)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # SI-8(2)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # SI-8(3)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # SI-8(4)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # SI-8(5)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

        # SI-8(6)
        # Puppet Actions: None - PROCEDURAL REQUIREMENT

# SI-9: Information Input Restrictions
# Puppet Actions: None - PROCEDURAL REQUIREMENT

# SI-10: Information Accuracy, Completeness, Validity, and Authenticity
# Puppet Actions: None Required

# SI-11: Error Handling
# Puppet Actions: None - PROCEDURAL REQUIREMENT

# SI-12: Information Output Handling and Retention
# Puppet Actions: None - PROCEDURAL REQUIREMENT

##########################################################################
# UNIX STIG v5r1
##########################################################################


## (GEN000020: CAT II) (Previously - G001) The IAO and SA will ensure, if
## configurable, the UNIX host is configured to require a password for access
## to single-user and maintenance modes.
import "GEN000020"
include gen000020

## (GEN000440: CAT II) (Previously - G012) The SA will ensure all logon attempts (both
## successful and unsuccessful) are logged to a system log file.
import "GEN000440"
include gen000440

## (GEN000920: CAT II) The root root home directory will have permissions of 
## 700 or less permissive

import "GEN000920"
include gen000920

## (GEN000980: CAT II) (Previously - G026) The SA will ensure root can only log
## on as root from the system console, and then only when necessary to perform
## system maintenance.
import "GEN000980"
include gen000980

## (GEN001080: CAT III) (Previously - G229) The SA will ensure the root shell
## is not located in /usr if /usr is partitioned.
import "GEN001080"
include gen001080

## (GEN001280: CAT III) (Previously - G042) The SA will ensure all manual page
## files (i.e.,files in the man and cat directories) have permissions of 644,
## or more restrictive.
import "GEN001280"
include gen001280

## (GEN001460: CAT IV) (Previously - G052) The SA will ensure all home
## directories defined in the /etc/passwd file exist.
import "GEN001460"
include gen001460

## (GEN001560: CAT II) (Previously - G068) The user, application developers,
## and the SA will ensure user files and directories will have an initial
## permission no more permissive than 700, and never more permissive than 750.
import "GEN001560"
include gen001560

## (GEN001580: CAT II) (Previously - G058) The SA will ensure run control
## scripts have permissions of 755, or more restrictive.
import "GEN001580"
include gen001580

## (GEN001620: CAT II) (Previously - G061) The SA will ensure run control
## scripts files do not have the suid or sgid bit set.
# implemented in GEN001580

## (GEN001660: CAT II) (Previously - G611) The SA will ensure the owner of run
## control scripts is root.
# implemented in GEN001580

## (GEN001680: CAT II) (Previously - G612) The SA will ensure the group owner
## of run control scripts is root, sys, bin, other, or the system default.
# implemented in GEN001580

## (GEN001720: CAT II) The SA will ensure global initialization files have
## permissions of 644, or more restrictive.
## (GEN001740: CAT II) The SA will ensure the owner of global initialization
## files is root.
## (GEN001760: CAT II) The SA will ensure the group owner of global
## initialization files is root, sys, bin, other, or the system default.
## (GEN001780: CAT III) (Previously ??? G112) The SA will ensure global
## initialization files contain the command mesg ???n.
import "GEN0017x0"
include gen0017x0

## (GEN001800: CAT II) (Previously - G038) The SA will ensure all
## default/skeleton dot files have permissions of 644, or more restrictive.
import "GEN001800"
include gen001800

## (GEN001820: CAT II) The SA will ensure the owner of all default/skeleton
## dot files is root or bin.
import "GEN001820"
include gen001820

## (GEN002040: CAT I) The SA will ensure .rhosts, .shosts, hosts.equiv, nor
## shosts.equiv are used, unless justified and documented with the IAO.
import "GEN002040"
include gen002040

## (GEN002120: CAT II) (Previously ??? G069) The SA will ensure the /etc/shells
## (or equivalent) file exits.
import "GEN002120"
include gen002120

## (GEN002160: CAT I) (Previously ??? G072) The SA will ensure no shell has the
## suid bit set.
# implemented in GEN002120

## (GEN002180: CAT II) (Previously ??? G073) The SA will ensure no shell has the
## sgid bit set.
# implemented in GEN002120

## (GEN002200: CAT II) (Previously ??? G074) The SA will ensure the owner of all
## shells is root or bin.
# implemented in GEN002120

## (GEN002220: CAT II) (Previously ??? G075) The SA will ensure all shells
## (excluding /dev/null and sdshell) have permissions of 755, or more
## restrictive.
# implemented in GEN002120

## (GEN002320: CAT II) (Previously - G501) The SA will ensure the audio devices
## have permissions of 644, or more restrictive.
import "GEN002320"
include gen002320

## (GEN002340: CAT II) (Previously - G502) The SA will ensure the owner of
## audio devices is root.
# implemented in GEN002320

## (GEN002360: CAT II) (Previously - G504) The SA will ensure the group owner
## of audio devices is root, sys, or bin.
# implemented in GEN002320

## (GEN002560: CAT II) (Previously - G089) The SA will ensure the system and
## user umask is 077.
import "GEN002560"
include gen002560

## (GEN002640: CAT II) (Previously - G092) The SA will ensure logon capability
## to default system accounts (e.g., bin, lib, uucp, news, sys, guest, daemon,
## and any default account not normally logged onto) will be disabled by
## making the default shell /bin/false, /usr/bin/false, /sbin/false,
## /sbin/nologin, or /dev/null, and by locking the password.
import "GEN002640"
include gen002640

## (GEN002860: CAT II) (Previously - G674) The SA and/or IAO will ensure old
## audit logs are closed and new audit logs are started daily.
import "GEN002860"
include gen002860

## (GEN003040: CAT II) The SA will ensure the owner of crontabs is root or the
## crontab creator.
import "GEN003040"
include gen003040

## (GEN003060: CAT II) The SA will ensure default system accounts (with the
## possible exception of root) will not be listed in the cron.allow file. If
## there is only a cron.deny file, the default accounts (with the possible
## exception of root) will be listed there.
# implemented in AC-3

## (GEN003080: CAT II) (Previously - G205) The SA will ensure crontabs have
## permissions of 600, or more restrictive, (700 for some Linux crontabs, which
## is detailed in the UNIX Checklist).
# implemented in GEN003040

## (GEN003100: CAT II) (Previously - G206) The SA will ensure cron and crontab
## directories have permissions of 755, or more restrictive.
# implemented in GEN003040

## (GEN003120: CAT II) (Previously - G207) The SA will ensure the owner of the
## cron and crontab directories is root or bin.
# implemented in GEN003040

## (GEN003140: CAT II) (Previously - G208) The SA will ensure the group owner
## of the cron and crontab directories is root, sys, or bin.
# implemented in GEN003040

## (GEN003180: CAT II) (Previously - G210) The SA will ensure cron logs have
## permissions of 600, or more restrictive.
import "GEN003180"
include gen003180

## (GEN003300: CAT II) (Previously - G212) The SA will ensure the at.deny file
## is not empty.
# implemented in GEN003340

## (GEN003320: CAT II) (Previously - G213) The SA will ensure default system
## accounts (with the possible exception of root) are not listed in the
## at.allow file. If there is only an at.deny file, the default accounts
## (with the possible exception of root) will be listed there.
# implemented in GEN003340

## (GEN003340: CAT II) (Previously - G214) The SA will ensure the at.allow and
## at.deny files have permissions of 600, or more restrictive.
import "GEN003340"
include gen003340

## (GEN003400: CAT II) (Previously - G625) The SA will ensure the at (or
## equivalent) directory has permissions of 755, or more restrictive.
import "GEN003400"
include gen003400

## (GEN003420: CAT II) (Previously - G626) The SA will ensure the owner and
## group owner of the at (or equivalent) directory is root, sys, bin, or daemon.
# implemented in GEN003400

## (GEN003460: CAT II) (Previously - G629) The SA will ensure the owner and
## group owner of the at.allow file is root.
# implemented in GEN003340

## (GEN003480: CAT II) (Previously - G630) The SA will ensure the owner and
## group owner of the at.deny file is root.
# implemented in GEN003340

## (GEN003500: CAT III) The SA will ensure core dumps are disabled or
## restricted.
import "GEN003500"
include gen003500

## (GEN003520: CAT III) The SA will ensure the owner and group owner of the
## core dump  data directory is root with permissions of 700, or more
## restrictive.
import "GEN003520"
include gen003520

## (GEN003700: CAT II) The SA will ensure inetd (xinetd for Linux) is disabled
## if all inetd/xinetd based services are disabled.
import "GEN003700"
include gen003700

## (GEN003740: CAT II) (Previously - G108) The SA will ensure the inetd.conf
## (xinetd.conf for Linux) file has permissions of 440, or more restrictive.
## The Linux xinetd.d directory will have permissions of 755, or more
## restrictive. This is to include any directories defined in the includedir
## parameter.
import "GEN003740"
include gen003740

## (GEN003760: CAT II) (Previously - G109) The SA will ensure the owner of the
## services file is root or bin.
import "GEN003760"
include gen003760

## (GEN003780: CAT II) (Previously - G110) The SA will ensure the services
## file has permissions of 644, or more restrictive.
# implemented in GEN003760

## (GEN003860: CAT III) (Previously - V046) The SA will ensure finger is not
## enabled.
import "GEN003860"
include gen003860

## (GEN004360: CAT II) (Previously - G127) The SA will ensure the aliases file
## is owned by root.
import "GEN004360"
include gen004360

## (GEN004380: CAT II) (Previously - G128) The SA will ensure the aliases file
## has permissions of 644, or more restrictive.
# implemented in GEN004360

## (GEN004440: CAT IV) (Previously - G133) The SA will ensure the sendmail
## logging level (the detail level of e-mail tracing and debugging
## information) in the sendmail.cf file is set to a value no lower than
## nine (9).
import "GEN004440"
include gen004440

## (GEN004480: CAT II) (Previously - G135) The SA will ensure the owner of the
## critical sendmail log file is root.
import "GEN004480"
include gen004480

## (GEN004500: CAT II) (Previously - G136) The SA will ensure the critical
## sendmail log file has permissions of 644, or more restrictive.
# implemented in GEN004480

## (GEN004540: CAT II) The SA will ensure the help sendmail command is
## disabled.
import "GEN004540"
include gen004540

## (GEN004560: CAT II) (Previously - G646) To help mask the e-mail version,
## the SA will use the following in place of the original sendmail greeting
## message:
##   O SmtpGreetingMessage= Mail Server Ready ; $b
import "GEN004560"
include gen004560

## (GEN004580: CAT I) (Previously - G647) The SA will ensure .forward files
## are not used.
import "GEN004580"
include gen004580

## (GEN004640: CAT I) (Previously - V126) The SA will ensure the decode entry
## is disabled (deleted or commented out) from the alias file.
import "GEN004640"
include gen004640

## (GEN004880: CAT II) (Previously - G140) The SA will ensure the ftpusers
## file exists.
import "GEN004880"
include gen004880

## (GEN004900: CAT II) (Previously - G141) The SA will ensure the ftpusers
## file contains the usernames of users not allowed to use FTP, and contains,
## at a minimum, the system pseudo-users usernames and root.
# implemented in GEN004880

## (GEN004920: CAT II) (Previously - G142) The SA will ensure the owner of the
## ftpusers file is root.
# implemented in GEN004880

## (GEN004940: CAT II) (Previously - G143) The SA will ensure the ftpusers
## file has permissions of 640, or more restrictive.
# implemented in GEN004880

## (GEN005000: CAT I) (Previously - G649) The SA will implement the anonymous
## FTP account with a non-functional shell such as /bin/false.
# import "GEN005000"
# include gen005000
# superseded by LNX00320

## (GEN005400: CAT II) (Previously - G656) The SA will ensure the owner of the
## /etc/syslog.conf file is root with permissions of 640, or more restrictive.
## (GEN005420: CAT II) (Previously - G657) The SA will ensure the group owner
## of the /etc/syslog.conf file is root, sys, or bin.
import "GEN0054x0"
include gen0054x0

## (GEN005740: CAT II) (Previously - G178) The SA will ensure the owner of the
## export configuration file is root.
## (GEN005760: CAT III) (Previously - G179) The SA will ensure the export
## configuration file has permissions of 644, or more restrictive.
import "GEN0057x0"
include gen0057x0

## (GEN006100: CAT II) (Previously - L050) The SA will ensure the owner of
## the/etc/samba/smb.conf file is root.
import "GEN006100"
include gen006100

## (GEN006120: CAT II) (Previously - L051) The SA will ensure the group owner
## of the /etc/samba/smb.conf file is root.
# implemented in GEN006100

## (GEN006140: CAT II) (Previously - L052) The SA will ensure the
## /etc/samba/smb.conf file has permissions of 644, or more restrictive.
# implemented in GEN006100

## (GEN006160: CAT II) (Previously - L054) The SA will ensure the owner of
## smbpasswd is root.
import "GEN006160"
include gen006160

## (GEN006180: CAT II) (Previously - L055) The SA will ensure group owner of
## smbpasswd is root.
# implemented in GEN006160

## (GEN006200: CAT II) (Previously - L057) The SA will configure permissions
## for smbpasswd to 600, or more restrictive.
# implemented in GEN006160

## (GEN006260: CAT II) (Previously - L154) The SA will ensure the
## /etc/news/hosts.nntp file has permissions of 600, or more restrictive.
import "GEN006260"
include gen006260

## (GEN006280: CAT II) (Previously - L156) The SA will ensure the
## /etc/news/hosts.nntp.nolimit file has permissions of 600, or more
## restrictive.
import "GEN006280"
include gen006280

## (GEN006300: CAT II) (Previously - L158) The SA will ensure the
## /etc/news/nnrp.access file has permissions of 600, or more restrictive.
import "GEN006300"
include gen006300

## (GEN006320: CAT II) (Previously - L160) The SA will ensure the
## /etc/news/passwd.nntp file has permissions of 600, or more restrictive.
import "GEN006320"
include gen006320

## (GEN006340: CAT II) (Previously - L162) The SA will ensure the owner of all
## files under the /etc/news subdirectory is root or news.
import "GEN006340"
include gen006340

## (GEN006360: CAT II) (Previously - L164) The SA will ensure the group owner
## of all files in /etc/news is root or news.
# implemented in GEN006340
include gen006340

## (LNX00160: CAT II) (Previously - L074) The SA will ensure the grub.conf
## file has permissions of 600, or more restrictive.
import "LNX00160"
include lnx00160

## (LNX00220: CAT II) (Previously - L080) The SA will ensure the lilo.conf
## file has permissions of 600 or more restrictive.
import "LNX00220"
include lnx00220

## (LNX00320: CAT I) (Previously - L140) The SA will delete accounts that
## provide a special privilege such as shutdown and halt.
import "LNX00320"
include lnx00320

## (LNX00340: CAT II) (Previously - L142) The SA will delete accounts that
## provide no operational purpose, such as games or operator, and will delete
## the associated software.
import "LNX00340"
include lnx00340

## (LNX00360: CAT II) (Previously - L032) The SA will enable the X server
## –audit (at level 4) and –s option (with 15 minutes as the timeout time)
## options.
import "LNX00360"
include lnx00360

## (LNX00400: CAT II) (Previously - L044) The SA will ensure the owner of the
## /etc/login.access or /etc/security/access.conf file is root.
import "LNX00400"
include lnx00400

## (LNX00420: CAT II) (Previously - L045) The SA will ensure the group owner
## of the /etc/login.access or /etc/security/access.conf file is root.
# implemented in LNX00400

## (LNX00440: CAT II) (Previously - L046) The SA will ensure /etc/login.access
## or /etc/security/access.conf file will be 640, or more restrictive.
# implemented in LNX00400

## (LNX00480: CAT II) (Previously - L204) The SA will ensure the owner of the
## /etc/sysctl.conf file is root.
import "LNX00480"
include lnx00480

## (LNX00500: CAT II) (Previously - L206) The SA will ensure the group owner
## of the /etc/sysctl.conf file is root.
# implemented in LNX00480

## (LNX00520: CAT II) (Previously - L208) The SA will ensure the
## /etc/sysctl.conf file has permissions of 600, or more restrictive.
# implemented in LNX00480

## (LNX00580: CAT I) (Previously - L222) The SA will disable the
## Ctrl-Alt-Delete sequence unless the system is located in a controlled
## access area accessible only by SAs.
import "LNX00580"
include lnx00580

## (LNX00620: CAT II) The SA will ensure the group owner of the /etc/securetty
## file is root, sys, or bin.
# implemented in GEN000980

## (LNX00640: CAT II) The SA will ensure the owner of the /etc/securetty file
## is root.
# implemented in GEN000980

## (LNX00660: CAT II) The SA will ensure the /etc/securetty file has
## permissions of 640, or more restrictive.
# implemented in GEN000980

