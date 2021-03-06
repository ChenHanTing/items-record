import { Controller } from "stimulus"
import { isNil } from 'ramda'
import { whatIs } from '@/helper/utility'
import { DirectUpload } from "@rails/activestorage"

export default class extends Controller {
    static targets = ["input", "image"]

    changed() {
        Array.from(this.inputTarget.files).forEach(file => {
            const upload = new DirectUpload(file, this.postURL())
            whatIs('upload', upload);
            upload.create((error, blob) => {
                /* 只會創建一次 hidden field，不過 value 可以一直改 */
                this.hiddenInput().value = blob.signed_id
                /* this.inputTarget.type = "hidden" */
                this.imageTarget.src = `${this.getURL()}/${blob.signed_id}/${blob.filename}`
            })
        })
    }

    hiddenInput() {
        if (isNil(this._hiddenInput)) {
            this._hiddenInput = document.createElement('input')
            this._hiddenInput.name = this.inputTarget.name
            this._hiddenInput.type = "hidden"
            this.inputTarget.parentNode.insertBefore(this._hiddenInput, this.inputTarget.nextSibling)
        }
        return this._hiddenInput
    }

    postURL() {
        return '/rails/active_storage/direct_uploads'
    }

    getURL() {
        return '/rails/active_storage/blobs/redirect'
    }
}