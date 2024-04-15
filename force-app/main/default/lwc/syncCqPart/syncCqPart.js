import { LightningElement } from 'lwc';
import cqRestAPICallout from '@salesforce/apex/CQPartRestCallout.cqRestAPICallout';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import Integration_Admin from '@salesforce/customPermission/Integration_Admin';

export default class SyncCqPart extends LightningElement {

    hasIntegrationAdminPerm = Integration_Admin;
    get isSyncDisabled(){
        return !this.hasIntegrationAdminPerm;
    }
    async handleClick() {
        let result = await cqRestAPICallout();
			if(result){
                const e = new ShowToastEvent({
                                                title: 'Success!',
                                                message: 'Sync Successful',
                                                variant: 'success',
                                        });
                        this.dispatchEvent(e);
            }else{
                const e = new ShowToastEvent({
                                                title: 'Error!',
                                                message: 'Something went wrong!!'+ error,
                                                variant: 'error',
                                        });
                        this.dispatchEvent(e);
            }
		
    }
}