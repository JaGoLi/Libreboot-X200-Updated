/*
 *  Copyright (C) 2015 Leah Rowe <info@minifree.org>
 *
 *  This program is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */
 
/* Header file for demefactory.c */
 
#ifndef DEMEFACTORY_H
#define DEMEFACTORY_H

#include <stdio.h>
#include <string.h>
#include <stdint.h>

#include "common/descriptor_gbe.h"   /* common descriptor/gbe functions used by ich9deblob */
#include "common/x86compatibility.h" /* system/compiler compatibility checks. This code is not portable. */
#include "descriptor/descriptor.h"   /* structs describing what's in the descriptor region */
#include "gbe/gbe.h"                 /* structs describing what's in the gbe region */

int main();

#endif
